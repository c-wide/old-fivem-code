/**
 * Helper function to set a decor on an object
 */
export const SetDecor = (object: number, index: number): void => {
  if (!DecorExistOn(object, 'INVENTORY_ID')) {
    DecorRegister('INVENTORY_ID', 3);
    DecorSetInt(object, 'INVENTORY_ID', index as number);
  }
};
