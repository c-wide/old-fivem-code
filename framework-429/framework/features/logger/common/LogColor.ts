import type { LogLevels } from "~/logger/common/LogLevel";

export const LogColor: Record<LogLevels, string> = {
  error: "^8",
  warn: "^6",
  info: "^9",
  debug: "^4",
};
