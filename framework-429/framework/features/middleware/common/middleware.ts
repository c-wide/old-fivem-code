export type MiddlewareMetadata = {
  playerSrc?: number;
  [key: string]: unknown;
};

export type MiddlewareArgs = {
  meta: MiddlewareMetadata;
  next: Next;
};

export type MiddlewareList = Array<{
  func: (args: MiddlewareArgs) => void | Promise<void>;
  priority: number;
}>;

export type Next = (err?: string) => Promise<void | string>;

export async function executeMiddlewares(
  meta: MiddlewareMetadata,
  middlewares: MiddlewareList = [],
  index = 0
): Promise<void | string> {
  if (index >= middlewares.length) return;

  const mw = middlewares[index]?.func;
  if (!mw) return;

  return await mw({
    meta,
    next: async (err?: string) => {
      if (err) return err;
      return executeMiddlewares(meta, middlewares, index + 1);
    },
  });
}
