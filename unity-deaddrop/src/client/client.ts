import * as Cfx from 'fivem-js';

import {
  Delay,
  GetClosestDumpster,
  Draw3DText,
  Config,
  GetRandomIndex,
  DoesObjectExist,
  GetClosestObject,
  SetDecor,
} from '../utils';

/**
 * This array holds information about all
 * currently open deaddrop inventories.
 * This array is synced by the server whenever
 * an inventory is created or deleted.
 */
const dumpsterArray = [];

// Variable to hold the closest dumpster object, also acts as a bool for showing 3DText.
let closestDumpster = null;

/**
 * This function is called whenever a person is close
 * enough to set decors on a dumpster for an existing
 * inventory, but the script cannot find the dumpster
 * at the specified location. It does whats its named.
 */
const spawnDumpsterAndSetDecor = ({ index, coords, hash, heading }): void => {
  const tick = setTick(async () => {
    const [x, y, z] = coords;

    RequestModel(hash);

    while (!HasModelLoaded(hash)) {
      await Delay(500);
    }

    const dumpsterObject = CreateObjectNoOffset(hash, x, y, z, false, false, false);

    SetEntityHeading(dumpsterObject, heading);
    SetModelAsNoLongerNeeded(hash);

    DecorRegister('INVENTORY_ID', 3);
    DecorSetInt(dumpsterObject, 'INVENTORY_ID', index);

    clearTick(tick);
  });
};

/**
 * This tick checks every second if the player
 * is within X meters of a dumpster. If they are,
 * store the dumpster object in a variable.
 */
setTick(async () => {
  const object = GetClosestDumpster();

  if (object) {
    closestDumpster = object;

    await Delay(500);
  } else {
    closestDumpster = null;

    await Delay(1000);
  }
});

/**
 * This tick checks every second if there is
 * an object in the closestDumpster variable.
 * If there is display 3DText and wait for keypress.
 *
 * If the player attempts to open the inventory, check
 * if a decor already exists on the dumpster. If it does
 * that means this dumpster already has an inventory, so
 * open it. If not, create the new inventory and set decor
 */
setTick(async () => {
  if (closestDumpster) {
    const [x, y, z] = GetEntityCoords(closestDumpster, false);

    Draw3DText([x, y, z + 1.0], `${Config.InputKeyLabel} To Open`);

    if (IsControlJustReleased(0, Config.InputKey)) {
      if (IsPedInAnyVehicle(PlayerPedId(), true)) {
        exports['mythic_notify'].DoHudText('error', 'Please Exit Your Vehicle');
      } else if (DecorExistOn(closestDumpster, 'INVENTORY_ID')) {
        emitNet('unity-deaddrop:server:getInventory', DecorGetInt(closestDumpster, 'INVENTORY_ID'));
      } else {
        const index = await GetRandomIndex(dumpsterArray);
        const hash = GetEntityModel(closestDumpster);
        const coords = GetEntityCoords(closestDumpster, false);
        const heading = GetEntityPhysicsHeading(closestDumpster);
        emitNet('unity-deaddrop:server:createNewInventory', index, hash, coords, heading);
        SetDecor(closestDumpster, index as number);
      }
    }
  } else {
    await Delay(1000);
  }
});

/**
 * This tick checks every second if the player is
 * within X meters from a dumpster with an inventory.
 * If they are, find the object and set its decor.
 * If it cant find the object, spawn it. (should almost never happen)
 */
setTick(async () => {
  if (dumpsterArray.length > 0) {
    const { DoesObjectExistRadius: radius } = Config;
    for (const dumpster of dumpsterArray) {
      const [x, y, z] = dumpster.coords;
      const dumpsterVector = new Cfx.Vector3(x, y, z);

      if (dumpsterVector.distance(Cfx.Game.PlayerPed.Position) < Config.SetDecorDistance) {
        const doesObjectExist = DoesObjectExist(dumpster.coords, radius, dumpster.hash);

        if (doesObjectExist) {
          const object = GetClosestObject(dumpster.coords, radius, dumpster.hash);

          if (!DecorExistOn(object, 'INVENTORY_ID')) {
            SetDecor(object, dumpster.index as number);
          }
        } else {
          spawnDumpsterAndSetDecor(dumpster);
        }
      }
    }
    await Delay(1000);
  } else {
    await Delay(1000);
  }
});

/**
 * This event is triggered whenever someone creates a
 * deaddrop inventory. If the player is nearby the object,
 * set decors, otherwise push the data into dumpster array
 */
onNet(
  'unity-deaddrop:client:receiveDumpsterData',
  (dumpsterObject: { index: number; hash: number; coords: number[]; heading: number }) => {
    const { DoesObjectExistRadius: radius } = Config;

    const doesObjectExist = DoesObjectExist(dumpsterObject.coords, radius, dumpsterObject.hash);

    if (doesObjectExist) {
      const object = GetClosestObject(dumpsterObject.coords, radius, dumpsterObject.hash);
      SetDecor(object, dumpsterObject.index as number);
    }

    dumpsterArray.push(dumpsterObject);
  },
);

/**
 * This event is triggered the first time the client
 * connects to the server. If the player is nearby the object,
 * set decors, otherwise push the data in dumpster array
 */
onNet('unity-deaddrop:client:receiveAllCurrentDumpsters', currentDumpsters => {
  const { DoesObjectExistRadius: radius } = Config;
  for (const dumpster of currentDumpsters) {
    const doesObjectExist = DoesObjectExist(dumpster.coords, radius, dumpster.hash);

    if (doesObjectExist) {
      const object = GetClosestObject(dumpster.coords, radius, dumpster.hash);
      SetDecor(object, dumpster.index as number);
    }

    dumpsterArray.push(dumpster);
  }
});

/**
 * This event is triggered whenever the server decides
 * its time to remove a currently open deaddrop inventory
 */
onNet('unity-deaddrop:client:removeDeaddrop', index => {
  const { DoesObjectExistRadius: radius } = Config;
  for (const [i, v] of dumpsterArray.entries()) {
    if (v.index === index) {
      dumpsterArray.splice(i, 1);
      const doesObjectExist = DoesObjectExist(v.coords, radius, v.hash);
      if (doesObjectExist) {
        const object = GetClosestObject(v.coords, radius, v.hash);
        DecorRemove(object, 'INVENTORY_ID');
      }
      break;
    }
  }
});
