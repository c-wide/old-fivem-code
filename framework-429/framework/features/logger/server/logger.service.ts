import { injectable } from "tsyringe";
import { createLogger, format, transports } from "winston";
import "winston-daily-rotate-file";
import { LogColor } from "~/logger/common/LogColor";
import type { LogLevels } from "~/logger/common/LogLevel";
import { LogLevel } from "~/logger/common/LogLevel";
import type { DiscordLogOptions } from "~/logger/server/discord";
import { createDiscordLog } from "~/logger/server/discord";
import { config } from "~/utils/common/config";
import { CommonEvent, ServerEvent } from "~/utils/common/events";
import { env } from "~/utils/server/env";
import { _getPlayerIdentifiers } from "~/utils/server/identifiers";
import { generateUniqueId } from "~/utils/server/misc";

const logger = createLogger({
	level: config.logger.level,
	exitOnError: false,
	format: format.json(),
});

if (config.logger.console) {
	const consoleTransport = new transports.Console({
		level: "debug",
		format: format.printf(
			(info) =>
				`[^3${new Date().toLocaleString().replace(",", "")}^7] [${
					LogColor[info.level as keyof typeof LogColor]
				}${info.level.toUpperCase()}^7] [^5${info._feature}^7]: ${
					info.message
				}`,
		),
	});

	logger.add(consoleTransport);
}

if (config.logger.file) {
	const fileTransport = new transports.DailyRotateFile({
		level: "debug",
		dirname: "logs/%DATE%",
		filename: "combined.log",
	});

	logger.add(fileTransport);
}

if (config.logger.datadog) {
	const ddTransport = new transports.Http({
		level: "info",
		host: "http-intake.logs.datadoghq.com",
		path: `/api/v2/logs?dd-api-key=${env.DATADOG_KEY}&ddsource=${env.DATADOG_SOURCE}&service=framework-429`,
		ssl: true,
	});

	logger.add(ddTransport);
}

export type LogMeta = {
	correlationId?: string;
	[key: string]: unknown;
};

function log(
	featureName: string,
	level: LogLevels,
	message: string,
	meta: LogMeta = {},
): void {
	if (featureName.length === 0) {
		logger.warn("Logger context has not been set.", { _feature: "N/A" });
	}

	const _meta: LogMeta = {
		...meta,
	};

	if (level === LogLevel.Error) {
		if (!_meta.correlationId) {
			_meta.correlationId = generateUniqueId();
		}

		createDiscordLog(featureName, message, _meta, {
			title: `${featureName} Error Log`,
			color: "16718105",
		});
	}

	_meta._feature = featureName;

	logger[level](message, _meta);

	if (config.logger.console && Object.keys(_meta).length > 1) {
		console.log(_meta);
	}
}

@injectable()
export class LoggerService {
	private name = "";

	setContext(name: string): void {
		if (this.name !== "") {
			this.warn("Attempted to change logger context after initialization.");
			return;
		}

		this.name = name.match(/(\w+)(Controller|Service|Repository)/)?.[1] ?? name;
	}

	get isContextSet() {
		return this.name !== "";
	}

	error(message: string, meta: LogMeta = {}): void {
		log(this.name, LogLevel.Error, message, meta);
	}

	warn(message: string, meta: LogMeta = {}): void {
		log(this.name, LogLevel.Warn, message, meta);
	}

	info(message: string, meta: LogMeta = {}): void {
		log(this.name, LogLevel.Info, message, meta);
	}

	debug(message: string, meta: LogMeta = {}): void {
		log(this.name, LogLevel.Debug, message, meta);
	}

	discord(
		message: string,
		meta: LogMeta = {},
		options: DiscordLogOptions = {},
	): void {
		createDiscordLog(this.name, message, meta, options);
	}
}

on(
	ServerEvent.ServerLog,
	(
		featureName: string,
		level: LogLevels,
		message: string,
		meta: LogMeta = {},
	) => {
		if (meta._source && typeof meta._source === "number") {
			meta._identifiers = _getPlayerIdentifiers(meta._source.toString());
		}

		log(featureName, level, message, meta);
	},
);

onNet(
	CommonEvent.ClientLog,
	(
		featureName: string,
		level: LogLevels,
		message: string,
		meta: LogMeta = {},
	) => {
		const source = globalThis.source;

		log(featureName, level, message, {
			...meta,
			_identifiers: _getPlayerIdentifiers(source.toString()),
			_clientLog: true,
		});
	},
);
