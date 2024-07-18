import { useState } from "react";
import EntityDebugger from "./EntityDebugger";
import { useNuiEvent } from "../hooks/useNuiEvent";

const defaultData: DebuggerData = {
  entity: "...",
  name: "...",
  hash: "...",
  coords: { x: 0, y: 0, z: 0 },
  distance: "...",
  heading: "...",
  rotation: { x: 0, y: 0, z: 0 },
  quaternion: { x: 0, y: 0, z: 0 },
  isMission: false,
  isNetworked: false,
  netOwner: "...",
  netHasControl: false,
  netID: "...",
};

export default function App() {
  const [showDebugger, setShowDebugger] = useState(false);
  const [debuggerData, setDebuggerData] = useState<DebuggerPayload>({
    data: defaultData,
    extras: {},
  });

  const [showZone, setShowZone] = useState(false);
  const [zoneName, setZoneName] = useState<string | null>(null);

  useNuiEvent<boolean>("setEntityDebuggerVisible", (visibility) => {
    setShowDebugger(visibility);
  });

  useNuiEvent<{ default: DebuggerData; extras?: AnyObject }>(
    "setDebuggerData",
    ({ default: data, extras }) => {
      setDebuggerData({ data, extras: extras || {} });
    }
  );

  useNuiEvent<boolean>("setZoneDisplayVisible", (visibility) => {
    setShowZone(visibility);
  });

  useNuiEvent<string>("setZoneName", (zoneName) => {
    setZoneName(zoneName);
  });

  return (
    <div>
      {showZone ? (
        <div className="text-3xl text-red-500">{zoneName}</div>
      ) : null}
      {showDebugger ? <EntityDebugger data={debuggerData} /> : null}
    </div>
  );
}
