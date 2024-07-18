import { IdentifierType } from "~/utils/server/identifiers";

// license2 should always be required, bad things happen if you remove it

type QueueConfig = {
	maxClients: number;
	maxPublicClients: number;
	requiredIdentifiers: Array<IdentifierType>;
	maxConnectionAttempts: number;
	maxConnectionAttemptsTimeWindow: number;
	queueGracePeriodTimeWindow: number;
	connectingGracePeriodTimeWindow: number;
	sessionGracePeriodTimeWindow: number;
};

export const queueConfig: QueueConfig = {
	maxClients: GetConvarInt("sv_maxclients", 0),
	maxPublicClients: GetConvarInt("sv_maxpublicclients", 0),
	requiredIdentifiers: ["license2"],
	maxConnectionAttempts: 10,
	maxConnectionAttemptsTimeWindow: 5 * 60000,
	queueGracePeriodTimeWindow: 5 * 60000,
	connectingGracePeriodTimeWindow: 5 * 60000,
	sessionGracePeriodTimeWindow: 2 * 60000,
};
