import { LogColor } from "~/logger/common/LogColor";
import type { LogLevels } from "~/logger/common/LogLevel";
import { config } from "~/utils/common/config";

export function createLog(
	featureName: string,
	level: LogLevels,
	message: string,
	meta?: Record<string, unknown>,
): void {
	if (!config.logger.console) return;

	console.log(
		`[^3${new Date().toLocaleString().replace(",", "")}^7] [${
			LogColor[level]
		}${level.toUpperCase()}^7] [^5${featureName}^7]: ${message}`,
	);

	if (meta) {
		console.log(meta);
	}
}
