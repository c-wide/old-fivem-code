import { singleton } from "tsyringe";

export function serviceBase(name?: string) {
  // biome-ignore lint: expected any
  return function <T extends { new (...args: any[]): any }>(constructor: T) {
    class ServiceBase extends constructor {
      // biome-ignore lint: expected any
      constructor(...args: Array<any>) {
        super(...args);

        if (this.logger && !this.logger.isContextSet) {
          this.logger.setContext(
            name ??
              constructor.name.match(/(\w+)Service/)?.[1] ??
              constructor.name
          );
        }
      }
    }

    Object.defineProperty(ServiceBase, "name", { value: constructor.name });

    singleton()(ServiceBase);

    return ServiceBase;
  };
}

export function Service(name: string) {
  return serviceBase(name);
}
