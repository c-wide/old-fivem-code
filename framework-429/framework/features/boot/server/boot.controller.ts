import { BootService } from "~/boot/server/boot.service";
import { Controller } from "~/decorators/server/Controller";
import { Event } from "~/decorators/server/events";
import { ServerEvent } from "~/utils/common/events";

@Controller()
export class BootController {
	constructor(private bootService: BootService) {}

	@Event(ServerEvent.OnServerResourceStart)
	async handleServerStart(name: string) {
		if (name !== GetCurrentResourceName()) return;
		await this.bootService.handleServerStart(name);
	}
}
