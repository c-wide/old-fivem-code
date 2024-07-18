export const StateBag = {
  Placeholder: "placeholder",
} as const;

export const GlobalStateBag = {
  Config: "config",
} as const;

export type StateBags = Enum<typeof StateBag>;
export type GlobalStateBags = Enum<typeof GlobalStateBag>;
export type AllStateBags = StateBags | GlobalStateBags;
