-------------
-- ESX Stuff
-------------
ESX = nil
Unity = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
    while Unity == nil do
        TriggerEvent('unity:import', function(obj) Unity = obj end, {'Utils'})
        Citizen.Wait(0)
    end
end)

----------------
-- BEGIN SCRIPT
----------------
local displayBankMarker = false
local displayBankText = false
local closestBank = nil
local nuiOpen = false
local openPosition = nil

------------------------------------------------------
-- Function to get nearby players server ids and send
-- them to the server before opening NUI window
------------------------------------------------------
function openNUI(disableDeposit)
    local playerPed = PlayerPedId()
    local isPlayerAlive = GetEntityHealth(playerPed) > 0
    local isPlayerInVehicle = IsPedInAnyVehicle(playerPed, true)

    if not isPlayerAlive then
        exports['mythic_notify']:DoHudText('error', 'You Can\'t Bank While Dead')
        return
    elseif isPlayerInVehicle then
        exports['mythic_notify']:DoHudText('error', 'Please Exit Your Vehicle')
        return
    end

    local nearbyPlayers = {}
    local currentPlayer = PlayerPedId()
    local playersInArea = ESX.Game.GetPlayersInArea(GetEntityCoords(currentPlayer), Config.QuickTransferDistance)
    
    for i=1, #playersInArea do
        local player = GetPlayerPed(playersInArea[i])
        
        if player ~= currentPlayer then
            local playerServerID = GetPlayerServerId(playersInArea[i])
            table.insert(nearbyPlayers, playerServerID)
        end
    end

    TriggerServerEvent('unity-banking:server:populateBankingData', nearbyPlayers, disableDeposit)
end

--------------------------------------------
-- Receive data from server, send it to NUI
-- update NUI route, then show NUI window
--------------------------------------------
RegisterNetEvent('unity-banking:client:populateNUIData')
AddEventHandler('unity-banking:client:populateNUIData', function(playerName, accountBalance, nearbyPlayersNames, transactionHistory, disableDeposit)
    openPosition = GetEntityCoords(PlayerPedId())
    nuiOpen = true

    SendNUIMessage({
        type = 'BANK_SET_DATA',
        data = {
            playerName = playerName,
            accountBalance = accountBalance,
            nearbyPlayersNames = nearbyPlayersNames,
            transactionHistory = transactionHistory,
            disableDeposit = disableDeposit
        }
    })

    SendNUIMessage({
        type = 'APP_SET_ROUTE',
        data = {
            page = 'bank',
        },
    })

    SendNUIMessage({ type = 'APP_SHOW' })
    SetNuiFocus(true, true)
end)

-------------------------------------------------
-- Update NUI data whenever a transaction occurs
-- if the player has the NUI window open.
-------------------------------------------------
RegisterNetEvent('unity-banking:client:updateNUIData')
AddEventHandler('unity-banking:client:updateNUIData', function(accountBalance, transactionHistory)
    if nuiOpen then
        SendNUIMessage({
            type = 'BANK_SET_DATA',
            data = {
                accountBalance = accountBalance,
                transactionHistory = transactionHistory,
            }
        })
    end
end)

RegisterNUICallback('withdraw', function(data, cb)
    TriggerServerEvent('unity-banking:server:withdrawMoney', data.amount)

    cb('ok')
end)

RegisterNUICallback('deposit', function(data, cb)
    TriggerServerEvent('unity-banking:server:depositMoney', data.amount)

    cb('ok')
end)

RegisterNUICallback('transfer', function(data, cb)
    TriggerServerEvent('unity-banking:server:transferMoney', data.accountId, data.amount)

    cb('ok')
end)

RegisterNUICallback('close', function(data, cb)
    SendNUIMessage({ type = 'APP_HIDE' })
    SetNuiFocus(false, false)
    nuiOpen = false
    openPosition = nil
    cb('ok')
end)

----------------------------------------------------
-- Get all nearby objects and store ATMs if present
-- Distance check from each ATM, if close enough
-- open the NUI window
----------------------------------------------------
RegisterCommand('atm', function()
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    local nearbyATMs = {}
    local objectHandle, object = FindFirstObject()
    local success

    repeat
        if Config.ATMHashes[GetEntityModel(object)] then
            table.insert(nearbyATMs, object)
        end

        success, object = FindNextObject(objectHandle, object)
    until not success

    EndFindObject(objectHandle)

    for i=1, #nearbyATMs do
        local distance = #(playerCoords - GetEntityCoords(nearbyATMs[i]))

        if distance < Config.ATMUseDistance then
            openNUI(Config.DisableATMDeposit)
            return
        end
    end

    exports['mythic_notify']:DoHudText('error', 'Please Get Closer Or Use A Different ATM')
end, false)

TriggerEvent('chat:addSuggestion', '/atm', 'Use Nearby ATM', {})

--------------------------
-- Thread to create blips
--------------------------
Citizen.CreateThread(function()
    for i=1, #Config.BankLocations do
        local blip = AddBlipForCoord(Config.BankLocations[i].x, Config.BankLocations[i].y, Config.BankLocations[i].z)
        SetBlipSprite(blip, Config.BlipSprite)
        SetBlipScale(blip, Config.BlipScale)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName(Config.BlipName)
        EndTextCommandSetBlipName(blip)
    end
end)

------------------------------------------------
-- Thread to check distance from bank locations
------------------------------------------------
Citizen.CreateThread(function()
    while true do
        local sleep = 1000

        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)

        for i=1, #Config.BankLocations do
            local distance = #(playerCoords.xy - vector2(Config.BankLocations[i].x, Config.BankLocations[i].y))

            if distance < Config.MarkerDisplayDistance then
                closestBank = Config.BankLocations[i]
                displayBankMarker = true

                if distance < Config.TextDisplayDistance then
                    displayBankText = true
                else
                    displayBankText = false
                end

                break
            else
                displayBankMarker = false
                displayBankText = false
                closestBank = nil
            end
        end

        Citizen.Wait(sleep)
    end
end)

---------------------------------------------------------------
-- Thread to display bank marker and text
-- If InputKey pressed, get nearby players then send to server
---------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        local sleep = 500

        if displayBankMarker then
            sleep = 0

            DrawMarker(Config.MarkerType, closestBank.x, closestBank.y, closestBank.z-0.99, 0, 0, 0, 0, 0, 0, Config.MarkerScale, Config.MarkerScale, Config.MarkerScale, Config.MarkerRGBA[1], Config.MarkerRGBA[2], Config.MarkerRGBA[3], Config.MarkerRGBA[4], Config.MarkerBobUpAndDown, Config.MarkerFaceCamera, 2, Config.MarkerRotate, false, false, false)

            if displayBankText then
                Unity.Utils.DrawText(closestBank.x, closestBank.y, closestBank.z+0.3, "[E] Use Bank")

                if IsControlJustReleased(0, Config.InputUseKey) then
                    openNUI(false)
                end
            end
        end

        Citizen.Wait(sleep)
    end
end)

-------------------------------------------------------
-- Thread to close NUI window if certain actions occur
-- Death, Inside Vehicle, Move To Far Away, etc...
-------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        local sleep = 1000

        if nuiOpen then
            local playerPed = PlayerPedId()
            local isPlayerAlive = GetEntityHealth(playerPed) > 101
            local isPlayerInVehicle = IsPedInAnyVehicle(playerPed, true)

            if openPosition then
                local distance = #(openPosition.xy - GetEntityCoords(playerPed).xy)

                if not isPlayerAlive or isPlayerInVehicle or distance > Config.ATMUseDistance then
                    SendNUIMessage({ type = 'APP_HIDE' })
                    SetNuiFocus(false, false)
                    nuiOpen = false
                    openPosition = nil
                end
            end
        end

        Citizen.Wait(sleep)
    end
end)