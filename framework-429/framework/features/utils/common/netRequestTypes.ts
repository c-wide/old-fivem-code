import { z } from "zod";

export type NetResponse<T = undefined> =
  | (T extends undefined ? { success: true } : { success: true; data: T })
  | { success: false; message: string };

export const netResponseSchema = z.object({
  success: z.boolean(),
  data: z.any().optional(),
  message: z.string().optional(),
});

export type NetRequest<T = undefined> = { source: number; data: T };

export type NetCallback<T = undefined> = (res: NetResponse<T>) => void;
