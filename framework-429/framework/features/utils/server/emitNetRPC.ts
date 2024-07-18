import { z } from "zod";
import { LogLevel } from "~/logger/common/LogLevel";
import type { CommonEvents } from "~/utils/common/events";
import { ServerEvent } from "~/utils/common/events";
import type { NetResponse } from "~/utils/common/netRequestTypes";
import { netResponseSchema } from "~/utils/common/netRequestTypes";

const rpcTimeoutLength = 10000;
const undefinedOptionalSchema = z.undefined().optional();
let counter = 0;

export function emitNetRPC<T = undefined>(
	eventName: CommonEvents,
	playerSrc: number,
	data?: unknown,
	schema?: z.Schema<T>,
): Promise<NetResponse<T>> {
	return new Promise((res) => {
		let hasTimedOut = false;

		const timeoutId = setTimeout(() => {
			hasTimedOut = true;

			res({
				success: false,
				message: `RPC: ${eventName} has timed out after ${rpcTimeoutLength}ms`,
			});
		}, rpcTimeoutLength);

		const listenEventName = `${eventName}:${counter++}-${Math.floor(
			Math.random() * Number.MAX_SAFE_INTEGER,
		).toString(36)}`;

		emitNet(eventName, playerSrc, listenEventName, data);

		const handleClientResp = (resData: NetResponse<T>) => {
			removeEventListener(listenEventName, handleClientResp);

			if (hasTimedOut) return;

			clearTimeout(timeoutId);

			if (schema) {
				const zRes = netResponseSchema
					.extend({
						data: resData.success ? schema : undefinedOptionalSchema,
						message: resData.success ? undefinedOptionalSchema : z.string(),
					})
					.safeParse(resData);

				if (zRes.success === false) {
					emit(
						ServerEvent.ServerLog,
						"NetRPC",
						LogLevel.Error,
						`Argument validation failed for RPC "${eventName}".`,
						{
							eventName,
							data: resData,
							errors: zRes.error.flatten().fieldErrors,
							_source: playerSrc,
						},
					);

					res({
						success: false,
						message: `Argument validation failed for RPC "${eventName}".`,
					});
				}
			}

			res(resData);
		};

		onNet(listenEventName, handleClientResp);
	});
}
