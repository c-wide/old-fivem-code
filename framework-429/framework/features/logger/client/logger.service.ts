import { injectable } from "tsyringe";
import { LogLevel } from "~/logger/common/LogLevel";
import type { LogLevels } from "~/logger/common/LogLevel";
import { LogSeverity } from "~/logger/common/LogSeverity";
import { createLog } from "~/logger/common/createLog";
import { config } from "~/utils/common/config";
import { ClientEvent, CommonEvent } from "~/utils/common/events";

function log(
	featureName: string,
	level: LogLevels,
	message: string,
	meta: Record<string, unknown> = {},
): void {
	if (featureName.length === 0) {
		createLog("N/A", LogLevel.Warn, "Logger context has not been set.");
	}

	if (LogSeverity[level] > LogSeverity[config.logger.level]) return;

	createLog(
		featureName,
		level,
		message,
		Object.keys(meta).length > 0 ? meta : undefined,
	);

	if (level !== LogLevel.Debug) {
		emitNet(CommonEvent.ClientLog, featureName, level, message, meta);
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

		this.name = name;
	}

	get isContextSet() {
		return this.name !== "";
	}

	error(message: string, meta: Record<string, unknown> = {}): void {
		log(this.name, LogLevel.Error, message, meta);
	}

	warn(message: string, meta: Record<string, unknown> = {}): void {
		log(this.name, LogLevel.Warn, message, meta);
	}

	info(message: string, meta: Record<string, unknown> = {}): void {
		log(this.name, LogLevel.Info, message, meta);
	}

	debug(message: string, meta: Record<string, unknown> = {}): void {
		log(this.name, LogLevel.Debug, message, meta);
	}
}

on(
	ClientEvent.ClientLog,
	(
		featureName: string,
		level: LogLevels,
		message: string,
		meta: Record<string, unknown> = {},
	) => {
		log(featureName, level, message, meta);
	},
);
