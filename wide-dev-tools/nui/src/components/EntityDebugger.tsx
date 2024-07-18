import { useEffect } from "react";
import Input from "./Input";

interface EntityDebuggerProps {
  data: DebuggerPayload;
}

export const isEnvBrowser = (): boolean => !(window as any).invokeNative;

async function fetchNui<T = any>(
  eventName: string,
  data?: any,
  mockData?: T
): Promise<T> {
  const options = {
    method: "post",
    headers: {
      "Content-Type": "application/json; charset=UTF-8",
    },
    body: JSON.stringify(data),
  };

  if (isEnvBrowser() && mockData) return mockData;

  const resourceName = (window as any).GetParentResourceName
    ? (window as any).GetParentResourceName()
    : "nui-frame-app";

  const resp = await fetch(`https://${resourceName}/${eventName}`, options);

  const respFormatted = await resp.json();

  return respFormatted;
}

function handleKeypress(e: KeyboardEvent) {
  if (e.key === "`") {
    fetchNui("giveControl");
  }
}

export default function EntityDebugger({ data }: EntityDebuggerProps) {
  const { data: payload } = data;

  useEffect(() => {
    document.addEventListener("keydown", handleKeypress);

    return () => {
      document.removeEventListener("keydown", handleKeypress);
    };
  }, []);

  return (
    <div className="h-full flex items-center ml-12 max-w-[350px]">
      <div className="grid grid-cols-12 gap-2">
        <div className="col-span-3">
          <Input label="Entity" value={payload.entity} />
        </div>
        <div className="col-span-5">
          <Input label="Entity Name" value={payload.name} />
        </div>
        <div className="col-span-4">
          <Input label="Entity Hash" value={payload.hash} />
        </div>

        <div className="col-span-12">
          <Input
            label="Entity Coords"
            value={`vector3(${payload.coords.x}, ${payload.coords.y}, ${payload.coords.z})`}
          />
        </div>

        <div className="col-span-6">
          <Input label="Distance To Entity" value={payload.distance} />
        </div>
        <div className="col-span-6">
          <Input label="Entity Heading" value={payload.heading} />
        </div>

        <div className="col-span-12">
          <Input
            label="Entity Rotation"
            value={`vector3(${payload.rotation.x}, ${payload.rotation.y}, ${payload.rotation.z})`}
          />
        </div>
        <div className="col-span-12">
          <Input
            label="Entity Quaternion"
            value={`vector3(${payload.quaternion.x}, ${payload.quaternion.y}, ${payload.quaternion.z})`}
          />
        </div>

        <div className="col-span-3">
          <Input
            label="M. Entity"
            value={payload.isMission ? "true" : "false"}
          />
        </div>
        <div className="col-span-3">
          <Input
            label="Networked"
            value={payload.isNetworked ? "true" : "false"}
          />
        </div>
        <div className="col-span-3">
          <Input
            label="Net Ctrl"
            value={payload.netHasControl ? "true" : "false"}
          />
        </div>
        <div className="col-span-3">
          <Input label="Owner" value={payload.netOwner ?? "..."} />
        </div>

        <div className="col-span-4"></div>
        <div className="col-span-4">
          <Input label="Network ID" value={payload.netID ?? "..."} />
        </div>
      </div>
    </div>
  );
}
