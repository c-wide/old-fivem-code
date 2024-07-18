import { IdentifierType } from "@prisma/client";
import { Prisma } from "@prisma/client";
import { db } from "~/database/server/db";
import { Repository } from "~/decorators/server/Repository";
import { FetchedPlayer } from "~/player/server/misc";
import { PlayerIdentifiers } from "~/utils/server/identifiers";

@Repository()
export class PlayerRepository {
	async findPlayerByLicense(license: string): Promise<FetchedPlayer | null> {
		const player = await db.player.findFirst({
			where: {
				identifiers: {
					some: {
						type: "license2",
						value: license,
						deletedAt: null,
					},
				},
			},
			select: {
				id: true,
				names: {
					where: {
						deletedAt: null,
					},
					select: {
						value: true,
					},
				},
				identifiers: {
					where: {
						deletedAt: null,
					},
					select: {
						type: true,
						value: true,
					},
				},
				tokens: {
					where: {
						deletedAt: null,
					},
					select: {
						value: true,
					},
				},
				permissions: {
					where: {
						deletedAt: null,
					},
					select: {
						value: true,
					},
				},
				tebexPurchase: {
					where: {
						deletedAt: null,
					},
					select: {
						packageId: true,
					},
				},
			},
		});

		if (player) {
			return player;
		}

		return null;
	}

	async createPlayer(
		name: string,
		identifiers: PlayerIdentifiers,
		tokens: Array<string>,
	): Promise<FetchedPlayer> {
		const player = await db.player.create({
			data: {
				names: {
					create: {
						value: name,
					},
				},
				identifiers: {
					create: Object.entries(identifiers).map(([type, value]) => ({
						type: type as IdentifierType,
						value,
					})),
				},
				tokens: {
					create: tokens.map((value) => ({ value })),
				},
			},
			select: {
				id: true,
				names: {
					select: {
						value: true,
					},
				},
				identifiers: {
					select: {
						type: true,
						value: true,
					},
				},
				tokens: {
					select: {
						value: true,
					},
				},
				permissions: {
					select: {
						value: true,
					},
				},
				tebexPurchase: {
					where: {
						deletedAt: null,
					},
					select: {
						packageId: true,
					},
				},
			},
		});

		return player;
	}

	async updatePlayerDetails(
		player: FetchedPlayer,
		newName: string,
		newIdentifiers: PlayerIdentifiers,
		newTokens: Array<string>,
	) {
		const operations = [];

		// Check if the new name already exists for the player, and add to operations if it doesn't.
		if (!player.names.some((name) => name.value === newName)) {
			operations.push(
				db.playerName.create({
					data: { playerId: player.id, value: newName },
				}),
			);
		}

		// Convert existing identifiers to a Set for efficient lookup.
		const existingIdentifierKeys = new Set(
			player.identifiers.map((id) => `${id.type}:${id.value}`),
		);

		// Determine which new identifiers need to be created.
		const identifiersToCreate = Object.entries(newIdentifiers)
			.filter(
				([type, value]) => !existingIdentifierKeys.has(`${type}:${value}`),
			)
			.map(([type, value]) => ({
				playerId: player.id,
				type: type as IdentifierType,
				value,
			}));

		// Add bulk identifier creation to operations if needed.
		if (identifiersToCreate.length > 0) {
			operations.push(
				db.playerIdentifier.createMany({
					data: identifiersToCreate,
				}),
			);
		}

		// Convert existing tokens to a Set for efficient lookup.
		const existingTokenValues = new Set(
			player.tokens.map((token) => token.value),
		);

		// Determine which new tokens need to be created.
		const tokensToCreate = newTokens
			.filter((newToken) => !existingTokenValues.has(newToken))
			.map((token) => ({ playerId: player.id, value: token }));

		// Add bulk token creation to operations if needed.
		if (tokensToCreate.length > 0) {
			operations.push(
				db.playerToken.createMany({
					data: tokensToCreate,
				}),
			);
		}

		// Update the player's latest login time.
		operations.push(
			db.player.update({
				where: { id: player.id },
				data: {
					latestLogin: new Date(),
				},
			}),
		);

		// Execute all operations in a single transaction.
		await db.$transaction(operations);
	}

	async checkForBan(identifiers: PlayerIdentifiers, tokens: Array<string>) {
		// TODO: add support for deletedAt

		const identifierConditions: Array<Prisma.PlayerIdentifierWhereInput> = [];

		for (const identifierType of [
			"discord",
			"fivem",
			"license",
			"license2",
			"steam",
		] as const) {
			if (identifiers[identifierType]) {
				identifierConditions.push({
					type: identifierType,
					value: identifiers[identifierType],
				});
			}
		}

		const player = await db.player.findFirst({
			where: {
				OR: [
					{
						identifiers: {
							some: {
								OR: identifierConditions,
							},
						},
					},
					{
						tokens: {
							some: {
								value: {
									in: tokens,
								},
							},
						},
					},
				],
				bans: {
					some: {
						OR: [
							{
								expiresAt: {
									gt: new Date(),
								},
							},
							{
								expiresAt: null,
							},
						],
						deletedAt: null,
					},
				},
			},
			include: {
				bans: {
					select: {
						id: true,
						reason: true,
						expiresAt: true,
					},
					orderBy: {
						createdAt: "desc",
					},
					take: 1,
				},
			},
		});

		if (player) {
			return {
				playerId: player.id,
				ban: player.bans[0],
			};
		}

		return null;
	}
}
