export const LogLevel = {
	Error: "error",
	Warn: "warn",
	Info: "info",
	Debug: "debug",
} as const;

export type LogLevels = Enum<typeof LogLevel>;
