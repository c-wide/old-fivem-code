import ShortUUID from "short-uuid";

const uuidTranslator = ShortUUID();

export function generateUniqueId(): string {
	return uuidTranslator.new();
}
