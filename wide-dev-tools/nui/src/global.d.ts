type Vector3 = { x: number; y: number; z: number };

interface DebuggerData {
  entity: string;
  name: string;
  hash: string;
  coords: Vector3;
  distance: string;
  heading: string;
  rotation: Vector3;
  quaternion: Vector3;
  isMission: boolean;
  isNetworked: boolean;
  netOwner: string;
  netHasControl: boolean;
  netID: string;
}

type AnyObject = { [key: string]: string };

interface DebuggerPayload {
  data: DebuggerData;
  extras: AnyObject;
}
