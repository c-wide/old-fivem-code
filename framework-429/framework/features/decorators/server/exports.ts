import type { z } from "zod";
import { setExportMetadata } from "~/decorators/common/exports";
import type { ServerExports } from "~/utils/common/exports";

export const Export = <T extends z.ZodTypeAny>(
  exportName: ServerExports,
  schemas?: [T]
) =>
  // biome-ignore lint: expected any
  function (target: any, key: string) {
    setExportMetadata(target, exportName, key, schemas);
  };
