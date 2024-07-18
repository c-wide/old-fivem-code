import { handleBootError } from "~/boot/server/handleBootError";
import { validateDbConnection } from "~/database/server/db";
import { Service } from "~/decorators/server/Service";
import { LoggerService } from "~/logger/server/logger.service";
import { MiddlewareService } from "~/middleware/server/middleware.service";
import { BootError } from "~/utils/common/error";
import { CommonMiddleware } from "~/utils/common/middleware";

@Service()
export class BootService {
	constructor(
		private logger: LoggerService,
		private middlewareService: MiddlewareService,
	) {}

	async handleServerStart(name: string) {
		try {
			await validateDbConnection();

			const res = await this.middlewareService.execute(
				CommonMiddleware.FrameworkReady,
			);

			if (res.success === false) {
				throw new BootError({
					code: "MIDDLEWARE_FAILURE",
					message: `Failed to execute ${CommonMiddleware.FrameworkReady} middleware`,
					meta: {
						reason: res.reason,
					},
				});
			}

			globalThis.isFrameworkReady = true;

			this.logger.info(`${name} started successfully!`);
		} catch (e) {
			handleBootError(e);
		}
	}
}
