import * as Cfx from 'fivem-js';
import { Config } from '../Config';

/**
 * Helper function to loop over an array of hashes
 * and check if the player is nearby an object
 * with that hash.
 */
export const GetClosestDumpster = (): number => {
  let object = 0;

  const { x, y, z } = Cfx.Game.PlayerPed.Position;

  for (const hash of Config.DumpsterHashes) {
    object = GetClosestObjectOfType(x, y, z, Config.GetDumpsterRadius, hash, false, false, false);

    if (object) {
      break;
    }
  }

  return object;
};
