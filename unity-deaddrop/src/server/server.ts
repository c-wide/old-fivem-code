import { ESXServer, Inventory, Delay, Config } from '../utils';

// This array holds all currently open inventory objects.
const currentDeaddrops = [];

/**
 * Helper function to update inventories,
 * if shouldOpen is true, open inventory.
 */
const triggerInventoryUpdates = (
  source: string,
  index: number,
  inventory,
  shouldOpen: boolean,
): void => {
  emitNet('esx_inventoryhud:client:setupDeaddropInventoryData', source, index, inventory);

  if (shouldOpen) {
    emitNet('esx_inventoryhud:client:openDeaddropInventory', source);
  } else {
    emitNet('esx_inventoryhud:client:refreshPlayerInventory', source);
  }
};

/**
 * Helper function to add or remove items
 * from a current inventory asynchronously
 */
const alterInventory = async (
  inventoryID: number,
  action: string,
  item,
  amount: number,
  source: string,
): Promise<void> => {
  for (const deaddrop of currentDeaddrops) {
    if (deaddrop.index === inventoryID) {
      switch (action) {
        case 'ADD':
          await deaddrop.addItem(item, amount);
          triggerInventoryUpdates(source, deaddrop.index, deaddrop.getInventory(), false);
          break;
        case 'REMOVE':
          await deaddrop.removeItems(item, amount);
          triggerInventoryUpdates(source, deaddrop.index, deaddrop.getInventory(), false);
          break;
      }
    }
  }
};

/**
 * Helper function to get an items count
 * from a inventory, asynchronously
 */
const getInventoryItemCount = async (
  inventoryID: number,
  name: string,
  uniqueID: string | null,
): Promise<number> => {
  let itemCount = 0;

  for (const deaddrop of currentDeaddrops) {
    if (deaddrop.index === inventoryID) {
      itemCount = await deaddrop.getItemCount(name, uniqueID);
      break;
    }
  }

  return itemCount;
};

const removeWeapon = (source, itemName): void => {
  emitNet('unity_inventory:removeFromActionBar', source, itemName);

  if (itemName.match(/^WEAPON/g)) {
    emitNet('unity_inventory:removeCurrentWeapon', source);
  }
};

/**
 * This tick checks every minute if its been
 * X amount of minutes since the last time the
 * deaddrop was opened. If it has, remove the
 * deaddrop from clients, then server, then
 * close ALL players inventories that are in
 * a deaddrop.
 */
setTick(async () => {
  if (currentDeaddrops.length > 0) {
    for (const [i, v] of currentDeaddrops.entries()) {
      const timeSinceLastOpen = new Date().getTime() - v.lastOpen;

      if (!v.inventory.length && Config.CloseEmptyInventoryTimer * 60000 <= timeSinceLastOpen) {
        emitNet('unity-deaddrop:client:removeDeaddrop', -1, v.index);
        currentDeaddrops.splice(i, 1);
        emitNet('esx_inventoryhud:client:forceCloseDeaddropInventory', -1);
        continue;
      }

      const randomAmountOfTime =
        (Math.floor(
          Math.random() * (Config.MaxMinutesBeforeDelete - Config.MinMinutesBeforeDelete + 1),
        ) +
          Config.MinMinutesBeforeDelete) *
        60000;

      if (randomAmountOfTime <= timeSinceLastOpen) {
        emitNet('unity-deaddrop:client:removeDeaddrop', -1, v.index);
        currentDeaddrops.splice(i, 1);
        emitNet('esx_inventoryhud:client:forceCloseDeaddropInventory', -1);
        continue;
      }
    }
  }

  await Delay(60000);
});

/**
 * This event is called whenever a player opens
 * a deaddrop and it doesnt currently have an inventory
 * assigned to it. Send data to all clients about deaddrop,
 * create the new inventory, push it, then open in-game inventory.
 */
onNet(
  'unity-deaddrop:server:createNewInventory',
  (index: number, hash: number, coords: number[], heading: number) => {
    const _source = source;
    emitNet('unity-deaddrop:client:receiveDumpsterData', -1, { index, hash, coords, heading });
    const inventory = new Inventory(index, hash, coords, heading);
    currentDeaddrops.push(inventory);
    triggerInventoryUpdates(_source, inventory.index, inventory.getInventory(), true);
  },
);

/**
 * This event is called whenever a player opens
 * a deaddrop and it currently has an inventory assigned.
 * Loop over all current deaddrops, send inventory data,
 * and open in-game inventory. Also, update lastOpen time.
 */
onNet('unity-deaddrop:server:getInventory', (inventoryID: number) => {
  const _source = source;

  for (const deaddrop of currentDeaddrops) {
    if (deaddrop.index === inventoryID) {
      triggerInventoryUpdates(_source, deaddrop.index, deaddrop.getInventory(), true);
      deaddrop.lastOpen = new Date().getTime();
      break;
    }
  }
});

/**
 * This event is called whenever a player attempts
 * to put an item into a deaddrop inventory.
 * If the player has enough of the item, remove it
 * from them and add it to the deaddrop inventory.
 */
onNet(
  'unity-deaddrop:server:PutIntoDeaddrop',
  async (inventoryID: number, { item, number: amount }) => {
    const _source = source;
    const xPlayer = ESXServer.GetPlayerFromId(parseInt(_source));

    if (item.type === 'item_standard') {
      const uniqueID = !item.uniqueID ? null : item.uniqueID;
      const playerItemCount = xPlayer.getInventoryItem(item.name, uniqueID).count;

      if (playerItemCount >= amount && amount > 0) {
        xPlayer.removeInventoryItem(item.name, amount, uniqueID);
        alterInventory(inventoryID, 'ADD', item, amount, _source);
        removeWeapon(_source, item.name);
      } else if (amount === 0 || amount >= playerItemCount) {
        xPlayer.removeInventoryItem(item.name, playerItemCount, uniqueID);
        alterInventory(inventoryID, 'ADD', item, playerItemCount, _source);
        removeWeapon(_source, item.name);
      }
    }
  },
);

/**
 * This event is called whenever a player attempts
 * to take an item out of a deaddrop inventory.
 * If the inventory has the amount requested, and
 * the player can carry the amount requested, give
 * them the items and remove it from the inventory.
 */
onNet(
  'unity-deaddrop:server:TakeFromDeaddrop',
  async (inventoryID: number, { item, number: amount }) => {
    const _source = source;
    const xPlayer = ESXServer.GetPlayerFromId(parseInt(_source));

    if (item.type === 'item_standard') {
      const uniqueID = !item.uniqueID ? null : item.uniqueID;
      const sourceItem = xPlayer.getInventoryItem(item.name, uniqueID);
      const inventoryItemCount = await getInventoryItemCount(inventoryID, item.name, uniqueID);

      if (amount > 0 && inventoryItemCount >= amount) {
        if (
          !sourceItem.limit ||
          sourceItem.limit === -1 ||
          sourceItem.count + amount <= sourceItem.limit
        ) {
          alterInventory(inventoryID, 'REMOVE', item, amount, _source);
          xPlayer.addInventoryItem(item.name, amount, uniqueID, item.itemData);
        } else {
          emitNet('mythic_notify:client:SendAlert', _source, {
            type: 'error',
            text: 'Not Enough Space',
          });
        }
      } else if (amount === 0 || amount >= inventoryItemCount) {
        if (
          !sourceItem.limit ||
          sourceItem.limit === -1 ||
          sourceItem.count + amount <= sourceItem.limit
        ) {
          alterInventory(inventoryID, 'REMOVE', item, inventoryItemCount, _source);
          xPlayer.addInventoryItem(item.name, inventoryItemCount, uniqueID, item.itemData);
        } else {
          emitNet('mythic_notify:client:SendAlert', _source, {
            type: 'error',
            text: 'Not Enough Space',
          });
        }
      }
    }
  },
);

/**
 * This event is called whenver a player
 * has first spawned into the world. Send
 * them all current deaddrops.
 */
on('unity-deaddrop:server:characterSpawned', (source: number) => {
  emitNet('unity-deaddrop:client:receiveAllCurrentDumpsters', source, currentDeaddrops);
});
