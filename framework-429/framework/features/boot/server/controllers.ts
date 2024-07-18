import { InjectionToken } from "tsyringe";
import { BootController } from "~/boot/server/boot.controller";
import { PlayerController } from "~/player/server/player.controller";

export const controllers: Array<InjectionToken> = [
	BootController,
	PlayerController,
];
