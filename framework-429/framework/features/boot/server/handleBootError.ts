import { LogLevel } from "~/logger/common/LogLevel";
import { createLog } from "~/logger/common/createLog";
import { Deferrals } from "~/player/server/misc";
import { BootError } from "~/utils/common/error";
import { ServerEvent } from "~/utils/common/events";
import { getErrorMessage } from "~/utils/common/misc";

export function handleBootError(e: unknown) {
	createLog(
		"Boot",
		LogLevel.Error,
		getErrorMessage(e),
		e instanceof BootError ? e.meta : undefined,
	);

	on(
		ServerEvent.PlayerConnecting,
		(_1: unknown, _2: unknown, deferrals: Deferrals) => {
			deferrals.done("The server is not currently accepting connections...");
		},
	);
}
