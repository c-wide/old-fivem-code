----------------
-- ESX NONSENSE
----------------
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-------------
-- FUNCTIONS
-------------
----------------------------------------
-- Function to retreive players
-- current balance. If account provided
-- use account, otherwise, use cash
----------------------------------------
function checkMoney(player, account)
    local xPlayer        = ESX.GetPlayerFromId(player)
    local currentAmount  = nil

    if account then
        currentAmount = xPlayer.getAccount(account).money
    else
        currentAmount = xPlayer.getMoney()
    end

    return currentAmount
end

------------------------------------
-- Function to give money to player
-- If account provided use account,
-- otherwise, use cash.
------------------------------------
function addMoney(player, amount, account)
    local xPlayer = ESX.GetPlayerFromId(player)

    if account then
        xPlayer.addAccountMoney(account, amount)
    else
        xPlayer.addMoney(amount)
    end
end

-----------------------------------
-- Function to remove money from
-- player. If account provided use
-- account, otherwise, use cash
-----------------------------------
function removeMoney(player, amount, account)
    local xPlayer = ESX.GetPlayerFromId(player)

    if account then
        xPlayer.removeAccountMoney(account, amount)
    else
        xPlayer.removeMoney(amount)
    end
end

-------------------------------------------------------
-- Function to calculate distance between two entities
-------------------------------------------------------
function DistanceBetweenCoords(ent1, ent2)
    local ped1 = GetPlayerPed(ent1)
    local ped2 = GetPlayerPed(ent2)

    local x1,y1,z1 = table.unpack(GetEntityCoords(ped1))
    local x2,y2,z2 = table.unpack(GetEntityCoords(ped2))
    local deltax = x1 - x2
    local deltay = y1 - y2
    local deltaz = y1 - y2
    
    dist = math.sqrt((deltax * deltax) + (deltay * deltay) + (deltaz * deltaz))
    xout = math.abs(deltax)
    yout = math.abs(deltay)
    zout = math.abs(deltaz)
    result = {distance = dist, x = xout, y = yout, z = zout}
    
    return result
end

----------
-- EVENTS
----------
------------------------------
-- Event to trigger Job start
-- Check if player has enough
-- money to rent vehicle
------------------------------
RegisterNetEvent('lsdwp:startJob')
AddEventHandler('lsdwp:startJob', function()
    TriggerClientEvent('lsdwp:startJob', source)
    -- local currentAmount = checkMoney(source, Config.AccountName)

    -- if currentAmount >= Config.VehicleRentalPrice then
    --     removeMoney(source, Config.VehicleRentalPrice, Config.AccountName)
    -- else
    --     local text = 'You Need $'..Config.VehicleRentalPrice..' To Rent A Vehicle'

    --     TriggerClientEvent('lsdwp:clearSpawnVehicleKey', source)
    --     TriggerClientEvent('mythic_notify:client:SendAlert', source, {
    --         type = 'error',
    --         text = text,
    --     })
    -- end
end)

------------------------------
-- Event to return vehicle
-- and end job. Add security
-- deposit back, then end job
------------------------------
RegisterNetEvent('lsdwp:returnVehicle')
AddEventHandler('lsdwp:returnVehicle', function()
    -- addMoney(source, Config.VehicleRentalPrice, Config.AccountName)
    TriggerClientEvent('lsdwp:endJob', source)
end)

-----------------------------------------
-- Event triggered on successful
-- completion of task. Select a
-- random amount from Minimum to Maximum
-- add money and inform player
-----------------------------------------
RegisterNetEvent('lsdwp:triggerPayout')
AddEventHandler('lsdwp:triggerPayout', function(target)
    local amount = math.random(Config.MinimumPayout, Config.MaximumPayout)
    if target then
        local distance = DistanceBetweenCoords(source, target)
        if distance.distance < Config.MaxDistanceBetweenPlayers then
            local addition = math.random(Config.MinimumAddition, Config.MaximumAddition)
            amount = amount + addition
        end
    end
    addMoney(source, amount, Config.AccountName)
    TriggerClientEvent('mythic_notify:client:SendAlert', source, {
        type = 'inform',
        text = 'You Earned $'..amount..' Dollars',
    })
end)

----------------------------------------------------------
-- Event triggered when a player is invited to co-op mode
-- Check if player invited themselves if not, send invite
-- to target client
----------------------------------------------------------
RegisterNetEvent('lsdwp:invitePlayer')
AddEventHandler('lsdwp:invitePlayer', function(targetPlayerId)
    if targetPlayerId == source then
        TriggerClientEvent('mythic_notify:client:SendAlert', source, {
            type = 'error',
            text = "You Can't Invite Yourself",
        })
        return
    end
    TriggerClientEvent('mythic_notify:client:SendAlert', source, {
        type = 'inform',
        text = "Inviting Friend...",
    })
    TriggerClientEvent('lsdwp:playerInvited', targetPlayerId, source, targetPlayerId)
end)

---------------------------------------------
-- ALL THESE EVENTS ARE SELF EXPLANATORY
-- THEY HANDLE COMMUNICATION BETWEEN CLIENTS
---------------------------------------------
RegisterNetEvent('lsdwp:inviteAccepted')
AddEventHandler('lsdwp:inviteAccepted', function(inviterId, playerId)
    TriggerClientEvent('lsdwp:targetPlayerAcceptedInvite', inviterId, playerId)
end)

RegisterNetEvent('lsdwp:sendJobInfo')
AddEventHandler('lsdwp:sendJobInfo', function(currentJob, childId)
    TriggerClientEvent('lsdwp:receiveJobInfo', childId, currentJob)
end)

RegisterNetEvent('lsdwp:updateTasks')
AddEventHandler('lsdwp:updateTasks', function(onsiteTasks, childId, currentJob)
    TriggerClientEvent('lsdwp:receiveTasks', childId, onsiteTasks, currentJob)
end)

RegisterNetEvent('lsdwp:triggerRemoveChildJobBlip')
AddEventHandler('lsdwp:triggerRemoveChildJobBlip', function(childId)
    TriggerClientEvent('lsdwp:removeChildJobBlip', childId)
end)

RegisterNetEvent('lsdwp:triggerRemoveTaskBlip')
AddEventHandler('lsdwp:triggerRemoveTaskBlip', function(blipLocation, targetId)
    TriggerClientEvent('lsdwp:removeTaskBlip', targetId, blipLocation)
end)

RegisterNetEvent('lsdwp:triggerRemoveTask')
AddEventHandler('lsdwp:triggerRemoveTask', function(task, targetId)
    TriggerClientEvent('lsdwp:removeTask', targetId, task)
end)

RegisterNetEvent('lsdwp:triggerClearChildId')
AddEventHandler('lsdwp:triggerClearChildId', function(parentId)
    TriggerClientEvent('lsdwp:clearChildId', parentId)
end)

RegisterNetEvent('lsdwp:triggerForceCleanup')
AddEventHandler('lsdwp:triggerForceCleanup', function(childId)
    TriggerClientEvent('lsdwp:forceCleanup', childId)
end)

RegisterNetEvent('lsdwp:triggerSetTaskInProgress')
AddEventHandler('lsdwp:triggerSetTaskInProgress', function(entityCoords, targetId)
    TriggerClientEvent('lsdwp:setTaskInProgress', targetId, entityCoords)
end)

RegisterNetEvent('lsdwp:triggerPlayerIsBusy')
AddEventHandler('lsdwp:triggerPlayerIsBusy', function(inviterId)
    TriggerClientEvent('lsdwp:playerIsBusy', inviterId)
end)

-- -----------------------------------------
-- -- TEMPORARY HELPER DURING DEVELOPMENT
-- -----------------------------------------
-- RegisterNetEvent('lsdwp:saveObject')
-- AddEventHandler('lsdwp:saveObject', function(data)
--     local f,err = io.open('resources\\lsdwp\\objects.txt', 'a')
--     if not f then return print(err) end

--     for k,v in pairs(data) do
--         f:write(tostring(v)..' \n')
--     end

--     f:close()
-- end)