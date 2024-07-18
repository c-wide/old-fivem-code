import {
	CommandOptions,
	setCommandMetadata,
} from "~/decorators/common/commands";
import { ServerCommands } from "~/utils/common/commands";

export const Command = (commandName: ServerCommands, options: CommandOptions) =>
	// biome-ignore lint: expected any
	function (target: any, key: string) {
		setCommandMetadata(target, commandName, options, key);
	};
