/**
 * Each inventory has a unique index and the hash, coords, and heading
 * of the dumpster the inventory is attached to. It also has information
 * about the last time a user opened the inventory. The inventory property
 * is an array of item objects as defined below.
 *
 * The getInventory() method returns the inventory array for the specific
 * class instance it is called on.
 *
 * addItem() and removeItem() are helper methods to asynchronously update the
 * inventory array.
 *
 * getItemCount() is a helper method to determine how much of one item the
 * inventory array currently has.
 *
 * The getter and setter for lastOpen will return/set the information being
 * held about the last time this inventory was opened.
 */
import { Config } from '../Config';

export class Inventory {
  readonly index: number;
  readonly hash: number;
  readonly coords: number[];
  readonly heading: number;
  private _lastOpen: number;
  private inventory: {
    canRemove: boolean;
    count: number;
    label: string;
    limit: number;
    name: string;
    rare: boolean;
    type: string;
    usable: boolean;
    uniqueID: string;
    itemData: any;
  }[];

  constructor(index: number, hash: number, coords: number[], heading: number) {
    this.index = index;
    this.hash = hash;
    this.coords = coords;
    this.heading = heading;
    this._lastOpen = new Date().getTime();
    this.inventory = [];
    this.shouldPutRandomItem();
  }

  getInventory():
    | {
        canRemove: boolean;
        count: number;
        label: string;
        limit: number;
        name: string;
        rare: boolean;
        type: string;
        usable: boolean;
        uniqueID: string;
        itemData: any;
      }[]
    | [] {
    return this.inventory;
  }

  addItem = async (itemData: any, amount: number): Promise<void> =>
    new Promise(res => {
      let itemAdded = false;

      if (this.inventory.length === 0) {
        itemAdded = true;
        this.inventory.push({ ...itemData, count: amount });
      } else {
        for (const item of this.inventory) {
          if (item.name === itemData.name) {
            if (itemData.uniqueID) {
              if (itemData.uniqueID === item.uniqueID) {
                itemAdded = true;
                item.count += amount;
                break;
              }
            } else {
              itemAdded = true;
              item.count += amount;
              break;
            }
          }
        }
      }

      if (!itemAdded) {
        this.inventory.push({ ...itemData, count: amount });
      }

      res();
    });

  removeItems = async ({ name, uniqueID }, amount: number): Promise<void> =>
    new Promise(res => {
      let remainder = 0;

      for (const [i, v] of this.inventory.entries()) {
        if (v.name === name) {
          if (uniqueID) {
            if (uniqueID === v.uniqueID) {
              remainder = v.count - amount;
            }
          } else {
            remainder = v.count - amount;
          }

          if (remainder < 0) {
            throw new Error('ITEM COUNT LOWER THAN 0, PLEASE CONTACT ADMIN');
          } else if (remainder === 0) {
            this.inventory.splice(i, 1);
          } else {
            v.count = remainder;
          }

          break;
        }
      }
      res();
    });

  getItemCount = async (name: string, uniqueID: string): Promise<number> =>
    new Promise(res => {
      let itemCount = 0;

      for (const item of this.inventory) {
        if (item.name === name) {
          if (uniqueID) {
            if (uniqueID === item.uniqueID) {
              itemCount = item.count;
              break;
            }
          } else {
            itemCount = item.count;
            break;
          }
        }
      }

      res(itemCount);
    });

  get lastOpen(): number {
    return this._lastOpen;
  }

  set lastOpen(currentTime) {
    this._lastOpen = currentTime;
  }

  shouldPutRandomItem(): void {
    const randomNumber = Math.random();

    for (const item of Config.Items) {
      if (randomNumber >= item.chance) {
        this.inventory.push(item);
      }
    }
  }
}
