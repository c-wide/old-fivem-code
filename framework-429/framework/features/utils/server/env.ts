import { z } from "zod";
import { config } from "~/utils/common/config";
import { BootError } from "~/utils/common/error";

export const env = {
	DATABASE_URL: process.env.DATABASE_URL,
	DATADOG_SOURCE: process.env.DATADOG_SOURCE,
	DATADOG_KEY: process.env.DATADOG_KEY,
	ERROR_WEBHOOK_URL: process.env.ERROR_WEBHOOK_URL,
} as const;

export const envSchema = z.object({
	DATABASE_URL: z.string().url(),
	DATADOG_SOURCE: z.string(),
	DATADOG_KEY: z.string(),
	ERROR_WEBHOOK_URL: z.union([z.literal(""), z.string().url()]),
});

declare global {
	namespace NodeJS {
		interface ProcessEnv extends z.infer<typeof envSchema> {}
	}
}

export function validateEnvVars(): void {
	const parsed = envSchema.safeParse(env);

	if (parsed.success === false) {
		throw new BootError({
			code: "INVALID_ENV_VARIABLES",
			message: "Invalid environment variables",
			meta: {
				errors: parsed.error.flatten().fieldErrors,
			},
		});
	}

	if (
		config.logger.datadog &&
		(env.DATADOG_SOURCE.length === 0 || env.DATADOG_KEY.length === 0)
	) {
		throw new BootError({
			code: "INVALID_DATADOG_CONFIGURATION",
			message:
				"Datadog logging is enabled but environment variables are missing",
			meta: {
				datadogSource: env.DATADOG_SOURCE,
				datadogKey: env.DATADOG_KEY,
			},
		});
	}

	if (config.logger.webhook && env.ERROR_WEBHOOK_URL.length === 0) {
		throw new BootError({
			code: "INVALID_WEBHOOK_CONFIGURATION",
			message: "Webhook logging is enabled but error webhook is missing",
			meta: {
				errorWebhookUrl: env.ERROR_WEBHOOK_URL,
			},
		});
	}
}
