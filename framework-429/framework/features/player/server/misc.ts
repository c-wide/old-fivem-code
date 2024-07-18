import { Prisma } from "@prisma/client";
import { z } from "zod";
import { Permissions } from "~/player/common/permissions";

export type Deferrals = {
	defer: () => void;
	update: (message: string) => void;
	presentCard: (
		card: string,
		cb?: (data: unknown, rawData: string) => void,
	) => void;
	done: (failureReason?: string) => void;
};

export const QueueType = {
	Public: "public",
	Allowlist: "allowlist",
	Police: "police",
	EMS: "ems",
	DOJ: "doj",
} as const;

export type QueueTypes = Enum<typeof QueueType>;

export type QueuePlayer = {
	playerId: string;
	source: string;
	name: string;
	license2: string;
	queueType: QueueTypes;
	permissions: Array<Permissions>;
	priority: number;
	basePriority: number;
	priorityBoost: number;
	priorityBoostLabel: string;
	queuedAt: Date;
	gracePeriodStartTime?: Date;
	deferrals: Deferrals;
};

export const basePriorities: Record<QueueTypes, number> = {
	[QueueType.Public]: 0,
	[QueueType.Allowlist]: 100,
	[QueueType.Police]: 200,
	[QueueType.EMS]: 200,
	[QueueType.DOJ]: 200,
};

export const tebexPrioArgsSchema = z.object({
	action: z.enum(["add", "remove"]),
	fivemId: z.string().min(1),
	transactionId: z.string().min(1),
	server: z.string().min(1),
	price: z.string().min(1),
	currency: z.string().min(1),
	packageId: z.string().min(1),
});

export const tebexPrioPackages: Partial<
	Record<QueueTypes, Record<string, { name: string; priorityBoost: number }>>
> = {
	[QueueType.Public]: {
		"1111111": {
			name: "Public - Tier 1",
			priorityBoost: 0,
		},
	},
	[QueueType.Allowlist]: {
		"2222222": {
			name: "Allowlist - Tier 1",
			priorityBoost: 0,
		},
	},
};

export type FetchedPlayer = Prisma.PlayerGetPayload<{
	select: {
		id: true;
		names: { select: { value: true } };
		identifiers: { select: { type: true; value: true } };
		tokens: { select: { value: true } };
		permissions: { select: { value: true } };
		tebexPurchase: { select: { packageId: true } };
	};
}>;
