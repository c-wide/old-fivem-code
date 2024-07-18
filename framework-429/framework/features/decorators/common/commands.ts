import { AllCommands } from "~/utils/common/commands";

export type CommandSuggestion = {
	name: string;
	description: string;
};

export type CommandData = {
	name: AllCommands;
	description?: string;
	suggestions?: Array<CommandSuggestion>;
	isRestricted: boolean;
	key: string;
};

export type CommandOptions = {
	description?: string;
	suggestions?: Array<CommandSuggestion>;
	isRestricted: boolean;
};

export type CommandArgs = {
	source: number;
	args: Array<string>;
	rawCommand: string;
};

export const commandMetaKey = "commands";

export function setCommandMetadata(
	// biome-ignore lint: expected any
	target: any,
	commandName: AllCommands,
	options: CommandOptions,
	key: string,
) {
	if (!Reflect.hasMetadata(commandMetaKey, target)) {
		Reflect.defineMetadata(commandMetaKey, [], target);
	}

	const commandData: CommandData = {
		name: commandName,
		description: options.description,
		suggestions: options.suggestions,
		isRestricted: options.isRestricted,
		key,
	};

	Reflect.defineMetadata(
		commandMetaKey,
		[...Reflect.getMetadata(commandMetaKey, target), commandData],
		target,
	);
}

// biome-ignore lint: expected any
export function registerCommands(target: any) {
	if (!Reflect.hasMetadata(commandMetaKey, target)) return;

	const allCommands = Reflect.getMetadata(
		commandMetaKey,
		target,
	) as Array<CommandData>;

	const allSuggestions: Array<{
		name: `/${string}`;
		help: string;
		params?: Array<{ name: string; help: string }>;
	}> = [];

	for (const {
		name,
		description,
		suggestions,
		isRestricted,
		key,
	} of allCommands) {
		RegisterCommand(
			name,
			(source: number, args: Array<unknown>, rawCommand: string) => {
				target[key]({ source, args, rawCommand });
			},
			isRestricted,
		);

		if (description || suggestions) {
			allSuggestions.push({
				name: `/${name}`,
				help: description ?? "No description available.",
				params: suggestions?.map((suggestion) => ({
					name: suggestion.name,
					help: suggestion.description,
				})),
			});
		}
	}

	if (allSuggestions.length > 0) {
		emit("chat:addSuggestions", allSuggestions);
	}
}
