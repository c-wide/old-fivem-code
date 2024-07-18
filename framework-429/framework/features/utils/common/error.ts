export class ErrorBase<T extends string> extends Error {
	code: T;
	message: string;
	meta?: Record<string, unknown>;

	constructor({
		code,
		message,
		meta,
	}: {
		code: T;
		message: string;
		meta?: Record<string, unknown>;
	}) {
		super();
		this.code = code;
		this.message = message;
		this.meta = meta;
	}
}

export class BootError extends ErrorBase<
	| "INVALID_ENV_VARIABLES"
	| "CONTROLLER_RESOLUTION_FAILURE"
	| "DB_CONNECTION_FAILURE"
	| "INVALID_DATADOG_CONFIGURATION"
	| "INVALID_WEBHOOK_CONFIGURATION"
	| "MIDDLEWARE_FAILURE"
> {}
