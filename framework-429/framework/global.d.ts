declare global {
	type Enum<T extends object> = T[keyof T];

	type Brand<Base, Branding, Key extends string = "__brand__"> = Base & {
		[K in Key]: Branding;
	} & { __witness__: Base };

	// biome-ignore lint: expected any
	type AnyBrand = Brand<unknown, any>;

	type BaseOf<B extends AnyBrand> = B["__witness__"];

	type SuccessResponse<T = unknown> = {
		success: true;
		data?: T;
	};

	type ErrorResponse = {
		success: false;
		reason: string;
	};

	type GenericResponse<T = unknown> = SuccessResponse<T> | ErrorResponse;

	// biome-ignore lint: expected var
	var isFrameworkReady: boolean;
}

export {};
