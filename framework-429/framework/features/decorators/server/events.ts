import type { z } from "zod";
import { setEventMetadata } from "~/decorators/common/events";
import type { CommonEvents, ServerEvents } from "~/utils/common/events";

export const Event = (eventName: ServerEvents) =>
	// biome-ignore lint: expected any
	function (target: any, key: string) {
		setEventMetadata(target, eventName, key, "normal");
	};

export const NetEvent =
	<T extends z.ZodTypeAny>(eventName: CommonEvents, schemas?: Array<T>) =>
	// biome-ignore lint: expected any
	(target: any, key: string) => {
		setEventMetadata(target, eventName, key, "network", schemas);
	};

export const NetPromise =
	<T extends z.ZodTypeAny>(eventName: CommonEvents, schemas?: [T]) =>
	// biome-ignore lint: expected any
	(target: any, key: string) => {
		setEventMetadata(target, eventName, key, "promise", schemas);
	};
