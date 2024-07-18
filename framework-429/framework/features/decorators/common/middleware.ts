import type { AllMiddleware } from "~/utils/common/middleware";

export const middlewareMetaKey = "middleware";

export type MiddlewareData<T = AllMiddleware> = {
  path: T;
  priority: number;
  key: string;
};

export function setMiddlewareMetadata(
  // biome-ignore lint: expected any
  target: any,
  path: AllMiddleware,
  priority: number,
  key: string
) {
  if (!Reflect.hasMetadata(middlewareMetaKey, target)) {
    Reflect.defineMetadata(middlewareMetaKey, [], target);
  }

  const middlewareData: MiddlewareData = {
    path,
    key,
    priority,
  };

  Reflect.defineMetadata(
    middlewareMetaKey,
    [...Reflect.getMetadata(middlewareMetaKey, target), middlewareData],
    target
  );
}
