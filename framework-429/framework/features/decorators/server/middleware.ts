import type { MiddlewareData } from "~/decorators/common/middleware";
import {
	middlewareMetaKey,
	setMiddlewareMetadata,
} from "~/decorators/common/middleware";
import { middlewarePathMap } from "~/middleware/server/middleware.service";
import type {
	CommonMiddleware,
	ServerMiddleware,
} from "~/utils/common/middleware";

export const Middleware =
	(path: ServerMiddleware | CommonMiddleware, priority = 0) =>
	// biome-ignore lint: expected any
	(target: any, key: string) => {
		setMiddlewareMetadata(target, path, priority, key);
	};

// biome-ignore lint: expected any
export function registerMiddlewares(target: any) {
	if (!Reflect.hasMetadata(middlewareMetaKey, target)) return;

	const allMiddlewares = Reflect.getMetadata(
		middlewareMetaKey,
		target,
	) as Array<MiddlewareData<ServerMiddleware | CommonMiddleware>>;

	for (const { path, priority, key } of allMiddlewares) {
		if (!middlewarePathMap.has(path)) {
			middlewarePathMap.set(path, [
				{ func: target[key].bind(target), priority },
			]);
		} else {
			const pathData = middlewarePathMap.get(path);
			if (!pathData) return;

			for (let i = 0; i < pathData.length; i++) {
				const pathPrio = pathData[i]?.priority;
				if (typeof pathPrio === "number" && priority > pathPrio) {
					pathData.splice(i, 0, { func: target[key].bind(target), priority });
					break;
				}

				if (i === pathData.length - 1) {
					middlewarePathMap.set(path, [
						...pathData,
						{ func: target[key].bind(target), priority },
					]);

					break;
				}
			}
		}
	}
}
