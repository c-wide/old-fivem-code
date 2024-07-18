import { Service } from "~/decorators/client/Service";
import { LogLevel } from "~/logger/common/LogLevel";
import { createLog } from "~/logger/common/createLog";

@Service("Boot")
export class BootService {
	handleResourceStart(name: string) {
		createLog("Boot", LogLevel.Debug, `Resource ${name} started`);
		globalThis.isFrameworkReady = true;
	}
}
