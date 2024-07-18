import { setStateBagChangeHandlerMetadata } from "~/decorators/common/stateBag";
import type { AllStateBags } from "~/utils/common/stateBag";

export const StateBagChangeHandler = (
  keyFilter: AllStateBags,
  bagFilter?: "global"
) =>
  // biome-ignore lint: expected any
  function (target: any, key: string) {
    setStateBagChangeHandlerMetadata(target, key, keyFilter, bagFilter ?? "");
  };
