/**
 * Helper function to return an object at the provided location
 *
 * @param objectCoords Where to check for an object
 * @param radius What radius to check for an object at the coords provided
 * @param hash What object to look for at the location provided
 */
export const GetClosestObject = (objectCoords: number[], radius: number, hash: number): number => {
  const [x, y, z] = objectCoords;

  const object = GetClosestObjectOfType(x, y, z, radius, hash, false, false, false);

  return object;
};
