AddEventHandler('eventHandler:server:characterSpawned', function(source)
    TriggerClientEvent('unity-hud:cl_main:characterSpawned', source)
end)