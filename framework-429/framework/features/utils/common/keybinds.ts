export const InputType = {
  Keyboard: "KEYBOARD",
  MouseButton: "MOUSE_BUTTON",
  MouseWheel: "MOUSE_WHEEL",
} as const;

export const KeyboardKey = {
  Backspace: "BACK",
  Tab: "TAB",
  Enter: "RETURN",
  PauseBreak: "PAUSE",
  CapsLock: "CAPITAL",
  Escape: "ESCAPE",
  SpaceBar: "SPACE",
  PageUp: "PAGEUP",
  PageDown: "PAGEDOWN",
  End: "END",
  Home: "HOME",
  LeftArrow: "LEFT",
  UpArrow: "UP",
  RightArrow: "RIGHT",
  DownArrow: "DOWN",
  PrintScreen: "SNAPSHOT",
  Insert: "INSERT",
  Delete: "DELETE",
  Number0: "0",
  Number1: "1",
  Number2: "2",
  Number3: "3",
  Number4: "4",
  Number5: "5",
  Number6: "6",
  Number7: "7",
  Number8: "8",
  Number9: "9",
  A: "A",
  B: "B",
  C: "C",
  D: "D",
  E: "E",
  F: "F",
  G: "G",
  H: "H",
  I: "I",
  J: "J",
  K: "K",
  L: "L",
  M: "M",
  N: "N",
  O: "O",
  P: "P",
  Q: "Q",
  R: "R",
  S: "S",
  T: "T",
  U: "U",
  V: "V",
  W: "W",
  X: "X",
  Y: "Y",
  Z: "Z",
  LeftWindows: "LWIN",
  RightWindows: "RWIN",
  ContextMenu: "APPS",
  Numpad0: "NUMPAD0",
  Numpad1: "NUMPAD1",
  Numpad2: "NUMPAD2",
  Numpad3: "NUMPAD3",
  Numpad4: "NUMPAD4",
  Numpad5: "NUMPAD5",
  Numpad6: "NUMPAD6",
  Numpad7: "NUMPAD7",
  Numpad8: "NUMPAD8",
  Numpad9: "NUMPAD9",
  NumpadMultiply: "MULTIPLY",
  NumpadAdd: "ADD",
  NumpadSubtract: "SUBTRACT",
  NumpadDecimal: "DECIMAL",
  NumpadDivide: "DIVIDE",
  NumpadEquals: "NUMPADEQUALS",
  NumpadEnter: "NUMPADENTER",
  F1: "F1",
  F2: "F2",
  F3: "F3",
  F4: "F4",
  F5: "F5",
  F6: "F6",
  F7: "F7",
  F8: "F8",
  F9: "F9",
  F10: "F10",
  F11: "F11",
  F12: "F12",
  F13: "F13",
  F14: "F14",
  F15: "F15",
  F16: "F16",
  F17: "F17",
  F18: "F18",
  F19: "F19",
  F20: "F20",
  F21: "F21",
  F22: "F22",
  F23: "F23",
  F24: "F24",
  Numlock: "NUMLOCK",
  ScrollLock: "SCROLL",
  LeftShift: "LSHIFT",
  RightShift: "RSHIFT",
  LeftCtrl: "LCONTROL",
  RightCtrl: "RCONTROL",
  LeftAlt: "LMENU",
  RightAlt: "RMENU",
  SemiColon: "SEMICOLON",
  Equals: "EQUALS",
  Plus: "PLUS",
  Comma: "COMMA",
  Minus: "MINUS",
  Period: "PERIOD",
  ForwardSlash: "SLASH",
  BackSlash: "BACKSLASH",
  Tilde: "GRAVE",
  LeftBracket: "LBRACKET",
  RightBracket: "RBRACKET",
  Apostrophe: "APOSTROPHE",
} as const;

export const MouseButton = {
  Left: "MOUSE_LEFT",
  Right: "MOUSE_RIGHT",
  Middle: "MOUSE_MIDDLE",
  Extra1: "MOUSE_EXTRABTN1",
  Extra2: "MOUSE_EXTRABTN2",
  Extra3: "MOUSE_EXTRABTN3",
  Extra4: "MOUSE_EXTRABTN4",
  Extra5: "MOUSE_EXTRABTN5",
} as const;

export const MouseWheel = {
  WheelUp: "IOM_WHEEL_UP",
  WheelDown: "IOM_WHEEL_DOWN",
} as const;

export type InputTypes = Enum<typeof InputType>;
export type KeyboardKeys = Enum<typeof KeyboardKey>;
export type MouseButtons = Enum<typeof MouseButton>;
export type MouseWheelButtons = Enum<typeof MouseWheel>;
export type AllControls = KeyboardKeys | MouseButtons | MouseWheelButtons;
