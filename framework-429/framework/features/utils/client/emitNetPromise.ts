import type { CommonEvents } from "~/utils/common/events";
import type { NetResponse } from "~/utils/common/netRequestTypes";

const promiseTimeout = 15000;
let counter = 0;

export function emitNetPromise<T = undefined>(
	eventName: CommonEvents,
	data?: unknown,
): Promise<NetResponse<T>> {
	return new Promise((res) => {
		let hasTimedOut = false;

		const timeoutId = setTimeout(() => {
			hasTimedOut = true;

			res({
				success: false,
				message: `${eventName} has timed out after ${promiseTimeout}ms`,
			});
		}, promiseTimeout);

		const listenEventName = `${eventName}:${counter++}-${Math.floor(
			Math.random() * Number.MAX_SAFE_INTEGER,
		).toString(36)}`;

		emitNet(eventName, listenEventName, data);

		const handleListenEvent = (cbData: NetResponse<T>) => {
			removeEventListener(listenEventName, handleListenEvent);

			if (hasTimedOut) return;

			clearTimeout(timeoutId);

			res(cbData);
		};

		onNet(listenEventName, handleListenEvent);
	});
}
