import "reflect-metadata";
import { resolveControllers } from "~/boot/common/resolveControllers";
import { controllers } from "~/boot/server/controllers";
import { handleBootError } from "~/boot/server/handleBootError";
import { validateEnvVars } from "~/utils/server/env";

function boot() {
	try {
		globalThis.isFrameworkReady = false;
		validateEnvVars();
		resolveControllers(controllers);
	} catch (e) {
		handleBootError(e);
	}
}

boot();
