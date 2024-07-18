export const ClientCommand = {
	Placeholder: "placeholder",
} as const;

export const ServerCommand = {
	TebexPrioChange: "tebexPrioChange",
} as const;

export type ClientCommands = Enum<typeof ClientCommand>;
export type ServerCommands = Enum<typeof ServerCommand>;
export type AllCommands = ClientCommands | ServerCommands;
