import { Service } from "~/decorators/server/Service";
import { emitNetRPC } from "~/utils/server/emitNetRPC";
import {
	_getPlayerIdentifiers,
	getPlayerIdentifierByType,
} from "~/utils/server/identifiers";
import { generateUniqueId } from "~/utils/server/misc";

@Service()
export class ServerUtilsService {
	emitNetRPC = emitNetRPC;

	getPlayerIdentifiers = _getPlayerIdentifiers;

	getPlayerIdentifierByType = getPlayerIdentifierByType;

	getPlayerTokens(source: string): Array<string> {
		const tokens: Array<string> = [];

		const numberOfTokens = GetNumPlayerTokens(source);

		for (let i = 0; i < numberOfTokens; i++) {
			tokens.push(GetPlayerToken(source, i));
		}

		return tokens;
	}

	generateUniqueId = generateUniqueId;
}
