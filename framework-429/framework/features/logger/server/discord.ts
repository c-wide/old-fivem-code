import fetch from "node-fetch";
import { LogLevel } from "~/logger/common/LogLevel";
import { createLog } from "~/logger/common/createLog";
import { config } from "~/utils/common/config";
import { env } from "~/utils/server/env";

export type DiscordLogOptions = {
	webhookUrl?: string;
	color?: string;
	title?: string;
};

export function createDiscordLog(
	featureName: string,
	message: string,
	meta: Record<string, unknown> = {},
	options: DiscordLogOptions = {},
): void {
	if (!config.logger.webhook) return;

	const embedFields = [
		{
			name: "Feature Name",
			value: featureName,
		},
		{
			name: "Message",
			value: message,
		},
	];

	if (Object.keys(meta).length > 0) {
		const prettyMetadata = JSON.stringify(meta, null, 2);

		if (prettyMetadata.length <= 1500) {
			embedFields.push({
				name: "Metadata",
				value: `\`\`\`${prettyMetadata}\`\`\``,
			});
		}
	}

	if (
		meta.correlationId !== undefined &&
		typeof meta.correlationId === "string"
	) {
		embedFields.push({
			name: "Correlation Id",
			value: `[${
				meta.correlationId
			}](https://app.datadoghq.com/logs?query=%40correlationId%3A${
				meta.correlationId
			}&cols=service%2Csource%2C%40_feature&index=%2A&messageDisplay=inline&from_ts=${
				Date.now() - 30 * 8.64e7
			}&to_ts=${Date.now()}&live=true)`,
		});
	}

	fetch(options.webhookUrl ?? env.ERROR_WEBHOOK_URL, {
		method: "post",
		headers: {
			"Content-Type": "application/json",
		},
		body: JSON.stringify({
			embeds: [
				{
					title: options.title ?? `${featureName} Log`,
					timestamp: new Date().toISOString(),
					color: options.color ?? "959977",
					fields: embedFields,
				},
			],
		}),
	})
		.then()
		.catch((e) =>
			createLog(
				"Logger",
				LogLevel.Error,
				"Unable to process the webhook request",
				{ errorMsg: e.message ?? "Unknown error" },
			),
		);
}
