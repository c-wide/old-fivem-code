import { z } from "zod";
import { handleArgsValidation } from "~/decorators/common/validate";
import { LogLevel } from "~/logger/common/LogLevel";
import type { AllEvents } from "~/utils/common/events";
import { ClientEvent, ServerEvent } from "~/utils/common/events";

const eventMetaKey = "events";

const EventTypes = ["normal", "network", "promise", "rpc"] as const;
type EventType = (typeof EventTypes)[number];

type EventData = {
	name: AllEvents;
	key: string;
	type: EventType;
	schemas?: Array<z.Schema>;
};

export function setEventMetadata(
	// biome-ignore lint: expected any
	target: any,
	eventName: AllEvents,
	key: string,
	eventType: EventType,
	schemas?: Array<z.Schema>,
) {
	if (!Reflect.hasMetadata(eventMetaKey, target)) {
		Reflect.defineMetadata(eventMetaKey, [], target);
	}

	const eventData: EventData = {
		name: eventName,
		key,
		type: eventType,
		schemas,
	};

	Reflect.defineMetadata(
		eventMetaKey,
		[...Reflect.getMetadata(eventMetaKey, target), eventData],
		target,
	);
}

// biome-ignore lint: expected any
export function registerEvents(target: any) {
	if (!Reflect.hasMetadata(eventMetaKey, target)) return;

	const allEvents = Reflect.getMetadata(
		eventMetaKey,
		target,
	) as Array<EventData>;

	for (const { name, key, type: eventType, schemas } of allEvents) {
		switch (eventType) {
			case "normal":
				on(name, (...args: Array<unknown>) => {
					target[key](...args);
				});

				break;
			case "network":
				onNet(name, (...args: Array<unknown>) => {
					const playerSrc = globalThis.source;

					if (
						schemas &&
						!handleArgsValidation(target.name, key, args, schemas, {
							_source: IsDuplicityVersion() ? playerSrc : null,
						})
					)
						return;

					target[key](...args);
				});

				break;
			case "promise":
				onNet(name, (respEventName: string, data?: unknown) => {
					const playerSrc = globalThis.source;

					if (
						schemas &&
						!handleArgsValidation(
							target.name,
							key,
							[respEventName, data],
							[z.string(), schemas[0] ?? z.never()],
							{
								_source: playerSrc,
							},
						)
					)
						return;

					Promise.resolve(target[key]({ source: playerSrc, data }))
						.then((resData: unknown) => {
							emitNet(respEventName, playerSrc, resData);
						})
						.catch((e: Error) => {
							emit(
								ServerEvent.ServerLog,
								"Decorators",
								LogLevel.Error,
								"Net Promise Error Occurred.",
								{ _source: playerSrc, errorMsg: e.message },
							);
						});
				});

				break;
			case "rpc":
				onNet(name, (respEventName: string, data?: unknown) => {
					Promise.resolve(target[key](data))
						.then((resData: unknown) => {
							emitNet(respEventName, resData);
						})
						.catch((e: Error) => {
							emit(
								ClientEvent.ClientLog,
								"Decorators",
								LogLevel.Error,
								"RPC Error Occurred.",
								{ errorMsg: e.message },
							);
						});
				});

				break;
		}
	}
}
