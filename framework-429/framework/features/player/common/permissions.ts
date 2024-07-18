export const Permission = {
	All: "all_permissions",
	ManageAdmins: "manage.admins",
	QueueAllowlist: "queue.allowlist",
	QueuePolice: "queue.police",
	QueueEMS: "queue.ems",
	QueueDOJ: "queue.doj",
} as const;

export type Permissions = Enum<typeof Permission>;

export type PermissionRecord = {
	permission: Permissions;
	expiresAt?: Date;
};
