import type { AllStateBags } from "~/utils/common/stateBag";

export const stateBagMetaKey = "stateBagChangeHandler";

type StateBagChangeHandlerData = {
  keyFilter: AllStateBags;
  bagFilter: "global" | "";
  methodKey: string;
};

export function setStateBagChangeHandlerMetadata(
  // biome-ignore lint: expected any
  target: any,
  methodKey: string,
  keyFilter: AllStateBags,
  bagFilter: "global" | ""
) {
  if (!Reflect.hasMetadata(stateBagMetaKey, target)) {
    Reflect.defineMetadata(stateBagMetaKey, [], target);
  }

  const stateBagChangeHandlerData: StateBagChangeHandlerData = {
    keyFilter,
    bagFilter,
    methodKey,
  };

  Reflect.defineMetadata(
    stateBagMetaKey,
    [
      ...Reflect.getMetadata(stateBagMetaKey, target),
      stateBagChangeHandlerData,
    ],
    target
  );
}

// biome-ignore lint: expected any
export function registerStateBagChangeHandlers(target: any) {
  if (!Reflect.hasMetadata(stateBagMetaKey, target)) return;

  const allStateBagChangeHandlers = Reflect.getMetadata(
    stateBagMetaKey,
    target
  ) as Array<StateBagChangeHandlerData>;

  for (const { keyFilter, bagFilter, methodKey } of allStateBagChangeHandlers) {
    AddStateBagChangeHandler(keyFilter, bagFilter, target[methodKey]);
  }
}
