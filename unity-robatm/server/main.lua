----------------
-- ESX NONSENSE
----------------
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

----------------
-- SCRIPT BEGIN
----------------
local atmTable       = {}
local globalCooldown = false
local minCash        = 550
local maxCash        = 800

----------
-- EVENTS
----------
--------------------------------------------------------
-- Event to verify if a user can start a robbery
-- Checks if the ATM has recently been broken into,
-- Checks if ANY ATM has recently been broken into,
-- Otherwise, insert details into table, set timeouts
-- for global / individual cooldown, and trigger client
-- to begin robbery
--------------------------------------------------------
RegisterNetEvent('unity-robatm:attemptRobbery')
AddEventHandler('unity-robatm:attemptRobbery', function(entityCoords, numOfCopsOnline)
    local _source       = source
    local maxCashAmount = math.random(minCash, maxCash)
    local atmIndex      = nil
    local camHeading    = nil

    for i=1, #atmTable do
        if tostring(entityCoords) == tostring(atmTable[i].location) then
            TriggerClientEvent('mythic_notify:client:SendAlert', source, {
                type = 'error',
                text = "This ATM Appears Recently Broken Into",
            })
            return
        end
    end

    if globalCooldown then
        TriggerClientEvent('mythic_notify:client:SendAlert', source, {
            type = 'error',
            text = "ATMs Are Currently Disabled",
        })
        return
    else
        globalCooldown = true
    end

    for k=1, #Config.ATMLocations do
        for l=1, #Config.ATMLocations[k].locations do
            if tostring(Config.ATMLocations[k].locations[l].vector) == tostring(entityCoords) then
                atmIndex   = k..l
                camHeading = Config.ATMLocations[k].locations[l].camHeading
                break
            end
        end
    end

    if numOfCopsOnline > 0 then
        maxCashAmount = maxCashAmount + Config.CopsOnlineBonus
    end

    table.insert(atmTable, { ['index'] = atmIndex, ['location'] = entityCoords, ['maxCash'] = maxCashAmount, ['currentCash'] = maxCashAmount, ['camHeading'] = camHeading })

    Citizen.SetTimeout(Config.GlobalCooldown, function()
        globalCooldown = false  
    end)

    Citizen.SetTimeout(Config.IndividualCooldown, function()
        for j=1, #atmTable do
            if tostring(entityCoords) == tostring(atmTable[j].location) then
                table.remove(atmTable, j)
                break
            end
        end
    end)

    TriggerClientEvent('unity-robatm:beginRobbery', _source, entityCoords, atmIndex)
end)

-------------------------------------------------------
-- Event called every X amount of time while a player
-- is robbing an ATM. Handles checking how much money
-- is left in ATM and how much money the player is
-- going to take this interval, if ATM is empty, exit
-------------------------------------------------------
RegisterNetEvent('unity-robatm:stealCash')
AddEventHandler('unity-robatm:stealCash', function(entityCoords)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    for i=1, #atmTable do
        if tostring(entityCoords) == tostring(atmTable[i].location) then
            local amountToSteal = math.random(Config.MinStealInterval, Config.MaxStealInterval)

            if amountToSteal >= atmTable[i].currentCash then
                xPlayer.addMoney(atmTable[i].currentCash)
                atmTable[i].currentCash = 0
                TriggerClientEvent('unity-robatm:ATMPocketsCleaned', _source)
            else
                xPlayer.addMoney(amountToSteal)
                atmTable[i].currentCash = atmTable[i].currentCash - amountToSteal
            end
        end
    end
end)

------------------------------------------------------------
-- Event to check if an ATM camera is available for viewing
------------------------------------------------------------
RegisterNetEvent('unity-robatm:attemptATMCam')
AddEventHandler('unity-robatm:attemptATMCam', function(camIndex)
    local _source    = source
    local camCoords  = nil
    local camHeading = nil

    for i=1, #atmTable do
        if atmTable[i].index == camIndex then
            camCoords  = atmTable[i].location
            camHeading = atmTable[i].camHeading
            break
        end
    end

    if camCoords then
        TriggerClientEvent('unity-robatm:setATMCam', _source, camCoords, camHeading)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, {
            type = 'error',
            text = "Camera Unavailable",
        })
    end
end)

----------------------------------------------------
-- Event to list all ATM cameras that are available
----------------------------------------------------
RegisterNetEvent('unity-robatm:getCamIndicies')
AddEventHandler('unity-robatm:getCamIndicies', function()
    local _source = source
    local message = 'Active Cameras: '

    if #atmTable == 0 then
        TriggerClientEvent('mythic_notify:client:SendAlert', source, {
            type = 'inform',
            text = 'No Active Cameras',
        })

        return
    end

    for i=1, #atmTable do
        if i > 1 then
            message = message..' - '
        end

        message = message .. '['..atmTable[i].index..']'
    end

    TriggerClientEvent('mythic_notify:client:SendAlert', source, {
        type = 'inform',
        text = message,
    })
end)

--------------------------------------------------------
-- Event to check how much money was stolen from an ATM
--------------------------------------------------------
RegisterNetEvent('unity-robatm:checkStolenAmount')
AddEventHandler('unity-robatm:checkStolenAmount', function(camIndex)
    local _source      = source
    local amountStolen = 0
    local atmIndex     = nil

    for i=1, #atmTable do
        if atmTable[i].index == camIndex then
            atmIndex     = atmTable[i].index
            amountStolen = atmTable[i].maxCash - atmTable[i].currentCash
            break
        end
    end

    if not atmIndex then
        TriggerClientEvent('mythic_notify:client:SendAlert', source, {
            type = 'error',
            text = 'ATM Is Fully Operational',
        })
        return
    end

    TriggerClientEvent('chat:addMessage', _source, {
        template = '<div style="width:fit; display: inline-block; max-width:95%; padding: 0.5vw; margin: 0.5vw; margin-top:0px; background-color: rgba(212, 47, 47, 0.7); border-radius: 15px;"><i class="fas fa-shield-alt"></i> {0} <i class="fas fa-arrow-right"></i> {1}</div>',
        args     = { 'Dispatch', '$'..amountStolen..' was reported stolen from ATM ['..atmIndex..']' }
    })
end)

------------------------------------------------
-- Event triggered when an ATM is being robbed,
-- Notifies police an ATM camera is active
------------------------------------------------
RegisterNetEvent('unity-robatm:sendATMChatMessage')
AddEventHandler('unity-robatm:sendATMChatMessage', function(atmIndex)
    local _source = source

    TriggerClientEvent('chat:addMessage', _source, {
        template = '<div style="width:fit; display: inline-block; max-width:95%; padding: 0.5vw; margin: 0.5vw; margin-top:0px; background-color: rgba(212, 47, 47, 0.7); border-radius: 15px;"><i class="fas fa-shield-alt"></i> {1}</div>',
        args     = { 'Information', 'ATM Camera ['..atmIndex..'] is active' }
    })
end)

------------------------------------------------------
-- Event to display help text, read the event name...
------------------------------------------------------
RegisterNetEvent('unity-robatm:displayHelpText')
AddEventHandler('unity-robatm:displayHelpText', function()
    local _source = source

    TriggerClientEvent('chat:addMessage', _source, {
        template = '<div style="width:fit; display: inline-block; max-width:95%; padding: 0.5vw; margin: 0.5vw; margin-top:0px; background-color: rgba(255, 184, 66, 0.7); border-radius: 15px;"><i class="fa fa-info-circle" aria-hidden="true"></i> {1}</div>',
        args     = { 'Information', 'ATM Command Help: /'..Config.ATMCamCommandName..': Exits camera if active or checks all active cameras | /'..Config.ATMCamCommandName..' [index]: If active, look through camera | /'..Config.ATMCamCommandName..' [index] check: Reports amount stolen from ATM' }
    })
end)