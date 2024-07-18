import { z } from "zod";
import { handleArgsValidation } from "~/decorators/common/validate";
import type { AllExports } from "~/utils/common/exports";

export const exportMetaKey = "exports";

export type ExportData = {
	name: AllExports;
	key: string;
	schemas?: [z.Schema];
};

export function setExportMetadata(
	// biome-ignore lint: expected any
	target: any,
	exportName: AllExports,
	key: string,
	schemas?: [z.Schema],
) {
	if (!Reflect.hasMetadata(exportMetaKey, target)) {
		Reflect.defineMetadata(exportMetaKey, [], target);
	}

	const exportData: ExportData = {
		name: exportName,
		key,
		schemas,
	};

	Reflect.defineMetadata(
		exportMetaKey,
		[...Reflect.getMetadata(exportMetaKey, target), exportData],
		target,
	);
}

// biome-ignore lint: expected any
export function registerExports(target: any) {
	if (!Reflect.hasMetadata(exportMetaKey, target)) return;

	const allExports = Reflect.getMetadata(
		exportMetaKey,
		target,
	) as Array<ExportData>;

	for (const { name, key, schemas } of allExports) {
		globalThis.exports(
			name,
			(data?: unknown, cb?: (data?: unknown) => void) => {
				if (
					schemas &&
					!handleArgsValidation(
						target.name,
						key,
						[data, ...(cb ? [cb] : [])],
						[schemas[0], ...(cb ? [z.function()] : [])],
					)
				)
					return;

				if (cb && typeof cb !== "function") return;

				const result = target[key](data);

				if (result instanceof Promise) {
					return result.then((value) => {
						cb?.(value);

						return value;
					});
				}

				cb?.(result);

				return result;
			},
		);
	}
}
