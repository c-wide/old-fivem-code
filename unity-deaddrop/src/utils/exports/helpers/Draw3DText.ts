/**
 * Helper function to draw 3DText
 *
 * @param coords Where to draw the 3DText
 * @param text What to draw
 */
export const Draw3DText = (coords: number[], text: string): void => {
  const [coordsX, coordsY, coordsZ] = coords;
  const [, _x, _y] = World3dToScreen2d(coordsX, coordsY, coordsZ);
  const factor = text.length / 320;

  SetTextScale(0.35, 0.35);
  SetTextFont(4);
  SetTextProportional(true);
  SetTextColour(255, 255, 255, 215);
  SetTextEntry('STRING');
  SetTextCentre(true);
  AddTextComponentString(text);
  DrawText(_x, _y);
  DrawRect(_x, _y + 0.0125, factor, 0.03, 0, 0, 0, 75);
};
