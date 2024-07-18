import { Controller } from "~/decorators/server/Controller";
import { Command } from "~/decorators/server/commands";
import { Event } from "~/decorators/server/events";
import { Middleware } from "~/decorators/server/middleware";
import { MiddlewareArgs } from "~/middleware/common/middleware";
import { Deferrals } from "~/player/server/misc";
import { PlayerService } from "~/player/server/player.service";
import { ServerCommand } from "~/utils/common/commands";
import { ServerEvent } from "~/utils/common/events";
import { CommonMiddleware } from "~/utils/common/middleware";

@Controller()
export class PlayerController {
	constructor(private playerService: PlayerService) {}

	@Command(ServerCommand.TebexPrioChange, { isRestricted: true })
	async tebexPrioChange(source: number, args: Array<string>) {
		await this.playerService.handleTebexPrioChange(source.toString(), args);
	}

	@Middleware(CommonMiddleware.FrameworkReady)
	frameworkReady({ next }: MiddlewareArgs) {
		this.playerService.handleFrameworkReady();
		return next();
	}

	@Event(ServerEvent.PlayerConnecting)
	async playerConnecting(name: string, _: unknown, deferrals: Deferrals) {
		await this.playerService.handlePlayerConnecting(
			globalThis.source.toString(),
			name,
			deferrals,
		);
	}

	@Event(ServerEvent.PlayerJoining)
	async playerJoining(oldSource: string) {
		await this.playerService.handlePlayerJoining(
			globalThis.source.toString(),
			oldSource,
		);
	}

	@Event(ServerEvent.PlayerDropped)
	async playerDropped(reason: string) {
		await this.playerService.handlePlayerDropped(
			globalThis.source.toString(),
			reason,
		);
	}
}
