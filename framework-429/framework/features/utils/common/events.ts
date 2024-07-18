export const clientPrefix = "429:client";
export const commonPrefix = "429:common";
export const serverPrefix = "429:server";

export const ClientEvent = {
	// FiveM Events
	OnClientResourceStart: "onClientResourceStart",

	// 429 Events
	ClientLog: `${clientPrefix}:clientLog`,
} as const;

export const CommonEvent = {
	ClientLog: `${commonPrefix}:clientLog`,
} as const;

export const ServerEvent = {
	// FiveM Events
	PlayerConnecting: "playerConnecting",
	PlayerJoining: "playerJoining",
	PlayerDropped: "playerDropped",
	OnServerResourceStart: "onServerResourceStart",

	// 429 Events
	ServerLog: `${serverPrefix}:serverLog`,
} as const;

export type ClientEvents = Enum<typeof ClientEvent>;
export type CommonEvents = Enum<typeof CommonEvent>;
export type ServerEvents = Enum<typeof ServerEvent>;
export type AllEvents = ClientEvents | CommonEvents | ServerEvents;
