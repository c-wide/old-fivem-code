import { InjectionToken, container } from "tsyringe";
import { LogLevel } from "~/logger/common/LogLevel";
import { createLog } from "~/logger/common/createLog";
import { BootError } from "~/utils/common/error";

export async function resolveControllers(controllers: Array<InjectionToken>) {
	createLog("Boot", LogLevel.Debug, "Initializing controllers...");

	try {
		for (const controller of controllers) {
			const instance = container.resolve(controller);

			createLog(
				"Boot",
				LogLevel.Debug,
				`${instance.name} controller initialized.`,
			);
		}
	} catch (e) {
		throw new BootError({
			code: "CONTROLLER_RESOLUTION_FAILURE",
			message: "Failed to resolve controllers",
			meta: {
				error: e,
			},
		});
	}
}
