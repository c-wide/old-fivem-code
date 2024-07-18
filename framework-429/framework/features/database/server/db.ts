import { PrismaClient } from "@prisma/client";
import { LogLevel } from "~/logger/common/LogLevel";
import { BootError } from "~/utils/common/error";
import { ServerEvent } from "~/utils/common/events";
import { getErrorMessage } from "~/utils/common/misc";

export const db = new PrismaClient();

export async function validateDbConnection() {
	try {
		await db.$connect();

		emit(
			ServerEvent.ServerLog,
			"Database",
			LogLevel.Info,
			"Database connection successfully established",
		);
	} catch (e) {
		const errorMsg = getErrorMessage(e);

		emit(
			ServerEvent.ServerLog,
			"Database",
			LogLevel.Error,
			"Unable to establish a connection to the database",
			{ error: errorMsg },
		);

		throw new BootError({
			code: "DB_CONNECTION_FAILURE",
			message: "Unable to establish a connection to the database",
			meta: {
				error: errorMsg,
			},
		});
	}
}
