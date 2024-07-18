/**
 * Helper function to check if an object exists at a specified location
 *
 * @param objectCoords Where to check for an object
 * @param radius What radius to check for an object at the coords provided
 * @param hash What object to look for at the location provided
 */
export const DoesObjectExist = (objectCoords: number[], radius: number, hash: number): number => {
  const [x, y, z] = objectCoords;

  const doesObjectExist = DoesObjectOfTypeExistAtCoords(x, y, z, radius, hash, false);

  return doesObjectExist;
};
