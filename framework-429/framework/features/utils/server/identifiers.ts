export type IdentifierType =
	| "discord"
	| "fivem"
	| "ip"
	| "license"
	| "license2"
	| "live"
	| "steam"
	| "xbl";

export type PlayerIdentifiers = {
	[T in IdentifierType]?: string;
};

export function _getPlayerIdentifiers(playerSrc: string): PlayerIdentifiers {
	return getPlayerIdentifiers(playerSrc).reduce<PlayerIdentifiers>(
		(identifiers, identifier) => {
			const splitId = identifier.split(":");

			if (splitId[0] && splitId[1]) {
				identifiers[splitId[0] as IdentifierType] = splitId[1];
			}

			return identifiers;
		},
		{},
	);
}

export function getPlayerIdentifierByType(
	playerSrc: string,
	identifierType: IdentifierType,
): string {
	return GetPlayerIdentifierByType(playerSrc, identifierType);
}
