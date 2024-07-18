export const ClientMiddleware = {
  Placeholder: "placeholder",
} as const;

export const CommonMiddleware = {
  FrameworkReady: "frameworkReady",
  PermissionChange: "permissionChange",
} as const;

export const ServerMiddleware = {
  Placeholder: "placeholder",
} as const;

export type ClientMiddleware = Enum<typeof ClientMiddleware>;
export type CommonMiddleware = Enum<typeof CommonMiddleware>;
export type ServerMiddleware = Enum<typeof ServerMiddleware>;
export type AllMiddleware =
  | ClientMiddleware
  | CommonMiddleware
  | ServerMiddleware;
