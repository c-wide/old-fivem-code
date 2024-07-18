import type { z } from "zod";
import { setEventMetadata } from "~/decorators/common/events";
import type { ClientEvents, CommonEvents } from "~/utils/common/events";

export const Event = (eventName: ClientEvents) =>
	// biome-ignore lint: expected any
	function (target: any, key: string) {
		setEventMetadata(target, eventName, key, "normal");
	};

export const NetEvent = (eventName: CommonEvents) =>
	// biome-ignore lint: expected any
	function (target: any, key: string) {
		setEventMetadata(target, eventName, key, "network");
	};

export const NetRPC = (eventName: CommonEvents) =>
	// biome-ignore lint: expected any
	function (target: any, key: string) {
		setEventMetadata(target, eventName, key, "rpc");
	};
