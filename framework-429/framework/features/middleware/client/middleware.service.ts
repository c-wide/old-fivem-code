import { Service } from "~/decorators/client/Service";
import { executeMiddlewares } from "~/middleware/common/middleware";
import type {
	MiddlewareList,
	MiddlewareMetadata,
} from "~/middleware/common/middleware";
import type {
	ClientMiddleware,
	CommonMiddleware,
} from "~/utils/common/middleware";

export const middlewarePathMap = new Map<
	ClientMiddleware | CommonMiddleware,
	MiddlewareList
>();

@Service("Middleware")
export class MiddlewareService {
	async execute(
		eventName: ClientMiddleware | CommonMiddleware,
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
