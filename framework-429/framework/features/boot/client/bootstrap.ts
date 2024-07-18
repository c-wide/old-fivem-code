import "reflect-metadata";
import { controllers } from "~/boot/client/controllers";
import { resolveControllers } from "~/boot/common/resolveControllers";

function boot() {
	try {
		globalThis.isFrameworkReady = false;
		resolveControllers(controllers);
	} catch (e) {
		// handle boot error
	}
}

boot();
