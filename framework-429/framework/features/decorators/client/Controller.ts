import { container, singleton } from "tsyringe";
import { registerKeybinds } from "~/decorators/client/keybinds";
import { registerMiddlewares } from "~/decorators/client/middleware";
import { registerCommands } from "~/decorators/common/commands";
import { registerEvents } from "~/decorators/common/events";
import { registerExports } from "~/decorators/common/exports";
import { registerStateBagChangeHandlers } from "~/decorators/common/stateBag";

export const controllerToken = "client-controllers";

export function Controller(name: string) {
	// biome-ignore lint: expected any
	return <T extends { new (...args: Array<any>): any }>(constructor: T) => {
		class ControllerBase extends constructor {
			name = name;

			// biome-ignore lint: expected any
			constructor(...args: Array<any>) {
				super(...args);

				if (this.logger && !this.logger.isContextSet) {
					this.logger.setContext(name);
				}

				registerEvents(this);
				registerExports(this);
				registerStateBagChangeHandlers(this);
				registerKeybinds(this);
				registerMiddlewares(this);
				registerCommands(this);
			}
		}

		Object.defineProperty(ControllerBase, "name", { value: constructor.name });

		singleton()(ControllerBase);

		container.registerSingleton(controllerToken, ControllerBase);

		return ControllerBase;
	};
}
