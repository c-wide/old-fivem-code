import { Service } from "~/decorators/server/Service";
import { executeMiddlewares } from "~/middleware/common/middleware";
import type {
	MiddlewareList,
	MiddlewareMetadata,
} from "~/middleware/common/middleware";
import type {
	CommonMiddleware,
	ServerMiddleware,
} from "~/utils/common/middleware";

export const middlewarePathMap = new Map<
	ServerMiddleware | CommonMiddleware,
	MiddlewareList
>();

@Service()
export class MiddlewareService {
	async execute(
		eventName: ServerMiddleware | CommonMiddleware,
		meta: MiddlewareMetadata = {},
	): Promise<GenericResponse> {
		const middlewares = middlewarePathMap.get(eventName);

		if (!middlewares) {
			return { success: true };
		}

		const res = await executeMiddlewares(meta, middlewares);

		if (res) {
			return { success: false, reason: res };
		}

		return { success: true };
	}
}
