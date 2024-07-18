import { BootService } from "~/boot/client/boot.service";
import { Controller } from "~/decorators/client/Controller";
import { Event } from "~/decorators/client/events";
import { ClientEvent } from "~/utils/common/events";

@Controller("Boot")
export class BootController {
	constructor(private bootService: BootService) {}

	@Event(ClientEvent.OnClientResourceStart)
	handleResourceStart(name: string) {
		if (name !== GetCurrentResourceName()) return;
		this.bootService.handleResourceStart(name);
	}
}
