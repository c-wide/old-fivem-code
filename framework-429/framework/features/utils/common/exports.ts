export const ClientExport = {
  Placeholder: "placeholder",
} as const;

export const ServerExport = {
  Placeholder: "placeholder",
} as const;

export type ClientExports = Enum<typeof ClientExport>;
export type ServerExports = Enum<typeof ServerExport>;
export type AllExports = ClientExports | ServerExports;
