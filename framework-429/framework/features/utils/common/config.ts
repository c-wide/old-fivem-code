import { CountryCode } from "~/locale/common/types";
import { LogLevels } from "~/logger/common/LogLevel";

type Config = {
	server: {
		name: string;
		locale: CountryCode;
	};
	logger: {
		level: LogLevels;
		console: boolean;
		datadog: boolean;
		webhook: boolean;
		file: boolean;
	};
};

export const config = {
	server: {
		name: "429gg",
		locale: "en",
	},
	logger: {
		level: "debug",
		console: true,
		datadog: false,
		webhook: false,
		file: false,
	},
} as const satisfies Config;
