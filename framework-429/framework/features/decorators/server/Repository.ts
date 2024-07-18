import { singleton } from "tsyringe";

export function Repository(name?: string) {
  // biome-ignore lint: expected any
  return function <T extends { new (...args: any[]): any }>(constructor: T) {
    class Repository extends constructor {
      // biome-ignore lint: expected any
      constructor(...args: Array<any>) {
        super(...args);

        if (this.logger && !this.logger.isContextSet) {
          this.logger.setContext(
            name ??
              constructor.name.match(/(\w+)Repository/)?.[1] ??
              constructor.name
          );
        }
      }
    }

    Object.defineProperty(Repository, "name", { value: constructor.name });

    singleton()(Repository);

    return Repository;
  };
}
