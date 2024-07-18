import { container, singleton } from "tsyringe";
import { registerCommands } from "~/decorators/common/commands";
import { registerEvents } from "~/decorators/common/events";
import { registerExports } from "~/decorators/common/exports";
import { registerStateBagChangeHandlers } from "~/decorators/common/stateBag";
import { registerMiddlewares } from "~/decorators/server/middleware";

export const controllerToken = "server-controllers";

export function Controller(name?: string) {
	// biome-ignore lint: expected any
	return <T extends { new (...args: Array<any>): any }>(constructor: T) => {
		const controllerName =
			name ??
			constructor.name.match(/(\w+)Controller/)?.[1] ??
			constructor.name;

		class ControllerBase extends constructor {
			name = controllerName;

			// biome-ignore lint: expected any
			constructor(...args: Array<any>) {
				super(...args);

				if (this.logger && !this.logger.isContextSet) {
					this.logger.setContext(controllerName);
				}

				registerEvents(this);
				registerExports(this);
				registerStateBagChangeHandlers(this);
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
