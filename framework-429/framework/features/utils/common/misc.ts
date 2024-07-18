export function debounce<F extends (...args: Parameters<F>) => ReturnType<F>>(
	fn: F,
	delay: number,
) {
	let timeout: ReturnType<typeof setTimeout> | null = null;

	return (...args: Parameters<F>) => {
		if (timeout) clearTimeout(timeout);

		timeout = setTimeout(() => {
			fn(...args);
		}, delay);
	};
}

export function getErrorMessage(error: unknown) {
	if (typeof error === "string") return error;

	if (
		error &&
		typeof error === "object" &&
		"message" in error &&
		typeof error.message === "string"
	) {
		return error.message;
	}

	return "Unknown Error";
}
