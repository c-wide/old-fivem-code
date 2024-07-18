import { BasePlayer, BasePlayerProps } from "~/player/common/BasePlayer";

export type ServerPlayerProps = BasePlayerProps;

export class ServerPlayer extends BasePlayer {
	constructor({ id, source }: ServerPlayerProps) {
		super({ id, source });
	}
}
