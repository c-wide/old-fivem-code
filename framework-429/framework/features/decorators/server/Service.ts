import { serviceBase } from "~/decorators/common/service";

export function Service(name?: string) {
  return serviceBase(name);
}
