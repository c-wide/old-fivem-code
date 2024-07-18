import { LogLevel } from "~/logger/common/LogLevel";
import { ClientEvent } from "~/utils/common/events";
import type {
  AllControls,
  InputType,
  InputTypes,
  KeyboardKeys,
  MouseButtons,
  MouseWheelButtons,
} from "~/utils/common/keybinds";

const keybindMetaKey = "keybinds";

const KeybindTypes = ["onKeyPress", "onKeyRelease"] as const;
type KeybindTypes = (typeof KeybindTypes)[number];

type KeybindData = {
  onKeyPress?: () => void;
  onKeyRelease?: () => void;
};

type KeybindMetadata = {
  onKeyPress?: string;
  onKeyRelease?: string;
  description?: string;
  inputType: InputTypes;
};

type AllKeybindMetadata = Record<AllControls, KeybindMetadata>;

const registeredKeybinds = new Map<AllControls, KeybindData>();

const setMetadata = (
  // biome-ignore lint: expected any
  target: any,
  key: string,
  keybindType: KeybindTypes,
  inputType: InputTypes,
  input: AllControls,
  description?: string
) => {
  if (!Reflect.hasMetadata(keybindMetaKey, target)) {
    Reflect.defineMetadata(keybindMetaKey, {}, target);
  }

  const keybindList = Reflect.getMetadata(
    keybindMetaKey,
    target
  ) as AllKeybindMetadata;

  if (keybindList[input]?.[keybindType]) {
    emit(
      ClientEvent.ClientLog,
      "Decorators",
      LogLevel.Warn,
      `Keybind type "${keybindType}" already exists for control "${input}".`
    );

    return;
  }

  const keybindData: KeybindMetadata = {
    ...(keybindList[input] ?? {}),
    [keybindType]: key,
    ...(description !== undefined ? { description } : {}),
    inputType,
  };

  Reflect.defineMetadata(
    keybindMetaKey,
    {
      ...keybindList,
      [input]: keybindData,
    },
    target
  );
};

export const OnKeyPress =
  <T extends InputTypes>(
    inputType: T,
    input: T extends typeof InputType.Keyboard
      ? KeyboardKeys
      : T extends typeof InputType.MouseButton
      ? MouseButtons
      : MouseWheelButtons,
    description: string
  ) =>
  // biome-ignore lint: expected any
  (target: any, key: string) => {
    setMetadata(target, key, "onKeyPress", inputType, input, description);
  };

export const OnKeyRelease =
  <T extends InputTypes>(
    inputType: T,
    input: T extends typeof InputType.Keyboard
      ? KeyboardKeys
      : T extends typeof InputType.MouseButton
      ? MouseButtons
      : MouseWheelButtons
  ) =>
  // biome-ignore lint: expected any
  (target: any, key: string) => {
    setMetadata(target, key, "onKeyRelease", inputType, input);
  };

// biome-ignore lint: expected any
export function registerKeybinds(target: any) {
  if (!Reflect.hasMetadata(keybindMetaKey, target)) return;

  const allKeybinds = Reflect.getMetadata(
    keybindMetaKey,
    target
  ) as AllKeybindMetadata;

  for (const [input, keybindData] of Object.entries(allKeybinds)) {
    if (!keybindData.onKeyPress) {
      emit(
        ClientEvent.ClientLog,
        "Decorators",
        LogLevel.Warn,
        `Attempted to register control "${input}" without input type "onKeyPress" defined.`
      );

      continue;
    }

    registeredKeybinds.set(input as AllControls, {
      onKeyPress: keybindData.onKeyPress
        ? target[keybindData.onKeyPress]
        : undefined,
      onKeyRelease: keybindData.onKeyRelease
        ? target[keybindData.onKeyRelease]
        : undefined,
    });

    RegisterKeyMapping(
      `+429Keybind ${input}`,
      keybindData.description ?? "Description not provided.",
      keybindData.inputType,
      input
    );
  }
}

RegisterCommand(
  "+429Keybind",
  (_: unknown, args: Array<string>) => {
    registeredKeybinds.get(args[0] as AllControls)?.onKeyPress?.();
  },
  true
);

RegisterCommand(
  "-429Keybind",
  (_: unknown, args: Array<string>) => {
    registeredKeybinds.get(args[0] as AllControls)?.onKeyRelease?.();
  },
  true
);
