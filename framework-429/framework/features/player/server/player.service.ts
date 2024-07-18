import { Service } from "~/decorators/server/Service";
import { LoggerService } from "~/logger/server/logger.service";
import { Permission, Permissions } from "~/player/common/permissions";
import { ServerPlayer } from "~/player/server/ServerPlayer";
import {
	Deferrals,
	FetchedPlayer,
	QueuePlayer,
	QueueType,
	QueueTypes,
	basePriorities,
	tebexPrioArgsSchema,
	tebexPrioPackages,
} from "~/player/server/misc";
import { PlayerRepository } from "~/player/server/player.repository";
import { queueConfig } from "~/player/server/queueConfig";
import { CommonUtilsService } from "~/utils/common/utils.service";
import { ServerUtilsService } from "~/utils/server/utils.service";

// TODO: handle restarting
// TODO: handle errors in playerConnecting
// TODO: ServerPlayer proxy? for stuff like deferrals etc...
// TODO: prevent duplicate identifiers
// TODO: frameworkReady vs frameworkBeforeReady
// TODO: fix import types

@Service()
export class PlayerService {
	private playersBySource = new Map<string, ServerPlayer>();
	private idToSourceMap = new Map<string, string>();
	private connectionAttempts = new Map<string, Array<Date>>();
	private playerQueue: Array<QueuePlayer> = [];
	private connectingPlayers = new Map<string, QueuePlayer>();
	private gracePeriodPlayers = new Map<
		string,
		{ player: ServerPlayer; gracePeriodStartTime: Date }
	>();

	constructor(
		private logger: LoggerService,
		private commonUtils: CommonUtilsService,
		private serverUtils: ServerUtilsService,
		private playerRepository: PlayerRepository,
	) {}

	getPlayerBySource(source: string): ServerPlayer | null {
		return this.playersBySource.get(source) ?? null;
	}

	getPlayerById(id: string): ServerPlayer | null {
		const source = this.idToSourceMap.get(id);

		if (source === undefined) {
			return null;
		}

		return this.getPlayerBySource(source);
	}

	private isPlayerConnected(source: string): boolean {
		return !!GetPlayerEndpoint(source);
	}

	private addToQueue(
		player: FetchedPlayer,
		name: string,
		source: string,
		license2: string,
		queueType: QueueTypes,
		deferrals: Deferrals,
	): void {
		this.logger.info(`Adding "${name}" to the "${queueType}" queue...`, {
			name,
			license2,
			playerId: player.id,
		});

		let priorityBoost = 0;
		let priorityBoostLabel = "";

		if (tebexPrioPackages[queueType] && player.tebexPurchase.length > 0) {
			for (const purchase of player.tebexPurchase) {
				const packageInfo = tebexPrioPackages[queueType]?.[purchase.packageId];

				if (packageInfo && packageInfo.priorityBoost > priorityBoost) {
					priorityBoost = packageInfo.priorityBoost;
					priorityBoostLabel = packageInfo.name;
				}
			}
		}

		const queuePlayer: QueuePlayer = {
			playerId: player.id,
			source,
			name,
			license2,
			queueType,
			permissions: player.permissions.map(
				(permission) => permission.value,
			) as Array<Permissions>,
			priority: basePriorities[queueType] + priorityBoost,
			basePriority: basePriorities[queueType],
			priorityBoost,
			priorityBoostLabel,
			queuedAt: new Date(),
			deferrals,
		};

		if (this.playerQueue.length === 0) {
			this.playerQueue.push(queuePlayer);
			return;
		}

		const last = this.playerQueue[this.playerQueue.length - 1];
		if (last && last.priority >= queuePlayer.priority) {
			this.playerQueue.push(queuePlayer);
			return;
		}

		const idx = this.playerQueue.findIndex(
			(plyr) => queuePlayer.priority > plyr.priority,
		);

		this.playerQueue.splice(idx, 0, queuePlayer);
	}

	handleFrameworkReady(): void {
		this.startMaxConnectionAttemptsInterval();
	}

	async handleTebexPrioChange(
		source: string,
		args: Array<string>,
	): Promise<void> {
		if (source !== "0") {
			this.logger.warn("Tebex command called from non-console source.", {
				args,
				license2: this.serverUtils.getPlayerIdentifierByType(
					source,
					"license2",
				),
			});

			return;
		}

		const parsedArgs = tebexPrioArgsSchema.safeParse(args);

		if (!parsedArgs.success) {
			this.logger.warn("Tebex command called with invalid args.", {
				args,
				errors: parsedArgs.error.flatten().fieldErrors,
			});

			return;
		}

		switch (parsedArgs.data.action) {
			case "add":
				// TODO: update database / player
				// TODO: adjust position if in queue
				// TODO: discord webhook?
				// TODO: make sure I pull tebex purchases when player connects above

				break;
			case "remove":
				break;
		}
	}

	async handlePlayerConnecting(
		source: string,
		name: string,
		deferrals: Deferrals,
	): Promise<void> {
		if (globalThis.isFrameworkReady === false) {
			deferrals.done(
				"The server is not ready yet. Please try again in a moment.",
			);

			return;
		}

		// initial deferral and delay required by spec
		deferrals.defer();
		await this.commonUtils.delay(0);

		// get player endpoint, identifiers, and tokens
		// reject connection if any of these are missing
		const endpoint = GetPlayerEndpoint(source);
		const identifiers = this.serverUtils.getPlayerIdentifiers(source);
		const tokens = this.serverUtils.getPlayerTokens(source);

		if (
			!endpoint ||
			tokens.length === 0 ||
			!queueConfig.requiredIdentifiers.every(
				(identifierType) => identifiers[identifierType],
			)
		) {
			const correlationId = this.serverUtils.generateUniqueId();

			this.logger.warn(
				`Unable to locate "${name}"'s identifying information.`,
				{
					name,
					source,
					endpoint,
					identifiers,
					tokens,
					correlationId,
				},
			);

			deferrals.done("Unable to locate identifiying information.");

			return;
		}

		this.logger.info(`"${name}" is attempting to connect...`, {
			name,
			source,
			license2: identifiers.license2,
		});

		// check if player has made too many connection attempts
		const timestamp = new Date();
		const connectionAttempts = this.connectionAttempts.get(endpoint) || [];
		const recentAttempts = connectionAttempts.filter(
			(attempt) =>
				timestamp.getTime() - attempt.getTime() <
				queueConfig.maxConnectionAttemptsTimeWindow,
		);

		if (recentAttempts.length >= queueConfig.maxConnectionAttempts) {
			this.logger.warn(`"${name}" has made too many connection attempts.`, {
				name,
				source,
				endpoint,
				license2: identifiers.license2,
			});

			deferrals.done("Too many connection attempts.");

			return;
		}

		recentAttempts.push(timestamp);
		this.connectionAttempts.set(endpoint, recentAttempts);

		// check if player is banned
		const playerBan = await this.playerRepository.checkForBan(
			identifiers,
			tokens,
		);

		if (playerBan !== null) {
			this.logger.info(`Banned player "${name}" attempted connection.`, {
				name,
				playerId: playerBan.playerId,
				banId: playerBan.ban?.id ?? "???",
			});

			// TODO: add reason & timestamp stuff
			deferrals.done("You are banned from this server.");

			return;
		}

		// stop execution if player is no longer connected
		if (this.isPlayerConnected(source) === false) return;

		// find or create player, update details if player exists
		// I'm not sure if typescript is dumb or I am, probably me
		if (!identifiers.license2) return;
		let player = await this.playerRepository.findPlayerByLicense(
			identifiers.license2,
		);

		// stop execution if player is no longer connected
		if (this.isPlayerConnected(source) === false) return;

		if (player === null) {
			this.logger.info(`Creating entry for first-time player "${name}"...`, {
				name,
				license2: identifiers.license2,
			});

			player = await this.playerRepository.createPlayer(
				name,
				identifiers,
				tokens,
			);
		} else {
			await this.playerRepository.updatePlayerDetails(
				player,
				name,
				identifiers,
				tokens,
			);
		}

		// check if player has reconnected before playerDropped was called
		if (this.getPlayerById(player.id) !== null) {
			this.logger.warn(
				`"${name}" has reconnected before playedDropped was called.`,
				{
					name,
					license2: identifiers.license2,
					playerId: player.id,
				},
			);

			deferrals.done("Please try again in a moment.");

			return;
		}

		// stop execution if player is no longer connected
		if (this.isPlayerConnected(source) === false) return;

		// TODO: if in session grace, present grace card

		// if player is in queue grace, re-add them to the queue
		const queuePlayer = this.playerQueue.find(
			(plyr) => plyr.playerId === player?.id,
		);

		if (queuePlayer !== undefined) {
			this.logger.info(
				`Re-adding "${name}" to the "${queuePlayer.queueType}" queue...`,
				{
					name,
					license2: identifiers.license2,
					playerId: player.id,
				},
			);

			queuePlayer.source = source;
			queuePlayer.name = name;
			queuePlayer.deferrals = deferrals;
			queuePlayer.gracePeriodStartTime = undefined;

			return;
		}

		// Determine which queues the player can join and add them to
		// the appropriate queue or present a card to select a queue
		const playerQueuePermissions = player.permissions.filter((permission) =>
			permission.value.startsWith("queue."),
		);

		if (playerQueuePermissions.length === 0) {
			this.addToQueue(
				player,
				name,
				source,
				identifiers.license2,
				QueueType.Public,
				deferrals,
			);
		} else if (
			playerQueuePermissions.length === 1 &&
			playerQueuePermissions[0]?.value === Permission.QueueAllowlist
		) {
			this.addToQueue(
				player,
				name,
				source,
				identifiers.license2,
				QueueType.Allowlist,
				deferrals,
			);
		} else {
			// TODO: present queue select card
		}
	}

	async handlePlayerJoining(source: string, oldSource: string): Promise<void> {}

	async handlePlayerDropped(source: string, reason: string): Promise<void> {}

	startMaxConnectionAttemptsInterval(): void {
		this.commonUtils.setImmediateInterval(() => {
			const timestamp = new Date();

			for (const [endpoint, attempts] of this.connectionAttempts) {
				const recentAttempts = attempts.filter(
					(attempt) =>
						timestamp.getTime() - attempt.getTime() <
						queueConfig.maxConnectionAttemptsTimeWindow,
				);

				if (recentAttempts.length === 0) {
					this.connectionAttempts.delete(endpoint);
				} else {
					this.connectionAttempts.set(endpoint, recentAttempts);
				}
			}
		}, 60000);
	}

	processGracePeriod(): void {
		const timestamp = new Date();

		// loop over players in queue
		// if not connected, start grace period
		// determine if player queue should be filtered
		let shouldFilterQueue = false;
		for (const plyr of this.playerQueue) {
			if (this.isPlayerConnected(plyr.source) === true) continue;

			if (plyr.gracePeriodStartTime === undefined) {
				plyr.gracePeriodStartTime = new Date();
				continue;
			}

			if (
				shouldFilterQueue === false &&
				timestamp.getTime() - plyr.gracePeriodStartTime.getTime() >
					queueConfig.queueGracePeriodTimeWindow
			) {
				shouldFilterQueue = true;
			}
		}

		// filter queue if necessary
		if (shouldFilterQueue === true) {
			this.playerQueue = this.playerQueue.filter((plyr) => {
				if (plyr.gracePeriodStartTime === undefined) return true;

				if (
					timestamp.getTime() - plyr.gracePeriodStartTime.getTime() >
					queueConfig.queueGracePeriodTimeWindow
				) {
					this.logger.info(
						`Removed "${plyr.name}" from the "${plyr.queueType}" queue due to inactivity.`,
						{
							name: plyr.name,
							license2: plyr.license2,
							playerId: plyr.playerId,
						},
					);

					return false;
				}
			});
		}

		// loop over connecting players
		// if time is up, remove from connecting players
		// how to handle allowing this player to connect again?

		// loop over grace period players
		// if time is up, remove from the Map
		this.gracePeriodPlayers.forEach((entry, key) => {
			if (
				timestamp.getTime() - entry.gracePeriodStartTime.getTime() >
				queueConfig.sessionGracePeriodTimeWindow
			) {
				this.logger.info(
					`Removed "${entry.player.getName()}" from grace period.`,
					{
						name: entry.player.getName(),
						playerId: entry.player.getId(),
					},
				);

				this.gracePeriodPlayers.delete(key);
			}
		});
	}

	startQueueInterval(): void {
		// update queue cards
		// add next player to server
		// update player counts

		this.commonUtils.setImmediateInterval(() => {
			this.processGracePeriod();
		}, 1000);
	}
}
