import type { z } from "zod";
import { LogLevel } from "~/logger/common/LogLevel";
import { ClientEvent, ServerEvent } from "~/utils/common/events";

type Errors = Array<Record<string, string[] | undefined>>;

type ValidationResult = { success: true } | { success: false; errors: Errors };

function validateArgs<T extends z.ZodTypeAny>(
  args: Array<unknown>,
  schemas: Array<T>
): ValidationResult {
  if (args.length !== schemas.length) {
    return {
      success: false,
      errors: [
        { argSchemaMismatch: ["Argument / schema count mismatch detected!"] },
      ],
    };
  }

  const errors: Errors = [];

  for (let i = 0; i < args.length; i++) {
    const res = schemas[i]?.safeParse(args[i]);

    if (!res) {
      return {
        success: false,
        errors: [
          { fatalError: ["Fatal error occurred during argument validation."] },
        ],
      };
    }

    if (!res.success) {
      errors.push(res.error.flatten().fieldErrors);
    }
  }

  if (errors.length > 0) {
    return { success: false, errors };
  }

  return { success: true };
}

export function handleArgsValidation<T extends z.ZodTypeAny>(
  controllerName: string,
  methodName: string,
  args: Array<unknown>,
  schemas: Array<T>,
  meta: Record<string, unknown> = {}
): boolean {
  const res = validateArgs(args, schemas);

  if (!res.success) {
    emit(
      IsDuplicityVersion() ? ServerEvent.ServerLog : ClientEvent.ClientLog,
      controllerName,
      LogLevel.Error,
      `"${methodName}" method argument validation failed.`,
      { controllerName, methodName, args, errors: res.errors, ...meta }
    );

    // TODO: If this is a player triggering this, we should probably log/ban

    return false;
  }

  return true;
}
