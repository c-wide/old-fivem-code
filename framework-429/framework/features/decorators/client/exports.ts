import type { z } from "zod";
import { setExportMetadata } from "~/decorators/common/exports";
import type { ClientExports } from "~/utils/common/exports";

export const Export = <T extends z.ZodTypeAny>(
  exportName: ClientExports,
  schemas?: [T]
) =>
  // biome-ignore lint: expected any
  function (target: any, key: string) {
    setExportMetadata(target, exportName, key, schemas);
  };
