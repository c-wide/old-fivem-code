import { ESXServer as ESXServerImport } from 'fivem-esx-js/server/esx_server';

export let ESXServer: ESXServerImport;
emit('esx:getSharedObject', obj => {
  ESXServer = obj;
});
