import { ESXClient as ESXClientImport } from 'fivem-esx-js/client/esx_client';

export let ESXClient: ESXClientImport;
emit('esx:getSharedObject', obj => {
  ESXClient = obj;
});
