local timeRemainingUnderwater = Config.MaxTimeUnderwater
local playerSpawned = false
local initialSpawn = false
local subtractor = 0.5
local bleedAmount = 0

local airTable = {
    subtractor * 2,
    subtractor * 4,
    subtractor * 6,
    subtractor * 8,
}

local displayTable = {
    healthbar = false,
    armorbar = false,
    foodbar = false,
    waterbar = false,
    stressbar = false,
    oxygenbar = false,
    voicebar = false,
}

local previousData = {
    health = {},
    armor = {},
    food = {},
    water = {},
    stress = {},
    oxygen = {},
    voice = {},
}

local forceDisplay = {}

local displayActions = {
    displayHealth = function(v, gameTimer)
        if not previousData.health.value then
            previousData.health.value = v
        elseif v ~= previousData.health.value then
            displayTable.healthbar = true
            previousData.health.displayTime = gameTimer
            previousData.health.value = v
        elseif bleedAmount > 0 then
            displayTable.healthbar = true
            previousData.health.displayTime = gameTimer
        elseif v < 50 then
            displayTable.healthbar = true
            previousData.health.displayTime = gameTimer
        elseif forceDisplay.healthbar then
            displayTable.healthbar = true
            previousData.health.displayTime = gameTimer
        else
            if previousData.health.displayTime and previousData.health.displayTime + Config.DisplayTime < gameTimer then
                displayTable.healthbar = false
                previousData.health.displayTime = nil
            end
        end
    end,
    playerArmor = function(v, gameTimer)
        if not previousData.armor.value then
            previousData.armor.value = v
        elseif v ~= previousData.armor.value then
            displayTable.armorbar = true
            previousData.armor.displayTime = gameTimer
            previousData.armor.value = v
        elseif v >= 1 and v < 50 then
            displayTable.armorbar = true
            previousData.armor.displayTime = gameTimer
        elseif forceDisplay.armorbar then
            displayTable.armorbar = true
            previousData.armor.displayTime = gameTimer
        else
            if previousData.armor.displayTime and previousData.armor.displayTime + Config.DisplayTime < gameTimer then
                displayTable.armorbar = false
                previousData.armor.displayTime = nil
            end
        end
    end,
    playerHunger = function(v, gameTimer)
        if not previousData.food.value then
            previousData.food.value = v
        elseif v > previousData.food.value then
            displayTable.foodbar = true
            previousData.food.displayTime = gameTimer
            previousData.food.value = v
        elseif v < 25 then
            displayTable.foodbar = true
            previousData.food.displayTime = gameTimer
        elseif forceDisplay.foodbar then
            displayTable.foodbar = true
            previousData.food.displayTime = gameTimer
        else
            if previousData.food.displayTime and previousData.food.displayTime + Config.DisplayTime < gameTimer then
                displayTable.foodbar = false
                previousData.food.displayTime = nil
            end
        end
    end,
    playerThirst = function(v, gameTimer)
        if not previousData.water.value then
            previousData.water.value = v
        elseif v > previousData.water.value then
            displayTable.waterbar = true
            previousData.water.displayTime = gameTimer
            previousData.water.value = v
        elseif v < 25 then
            displayTable.waterbar = true
            previousData.water.displayTime = gameTimer
        elseif forceDisplay.waterbar then
            displayTable.waterbar = true
            previousData.water.displayTime = gameTimer
        else
            if previousData.water.displayTime and previousData.water.displayTime + Config.DisplayTime < gameTimer then
                displayTable.waterbar = false
                previousData.water.displayTime = nil
            end
        end
    end,
    playerStress = function(v, gameTimer)
        if not previousData.stress.value then
            previousData.stress.value = v
        elseif v < previousData.stress.value then
            displayTable.stressbar = true
            previousData.stress.displayTime = gameTimer
            previousData.stress.value = v
        elseif v >= 75 then
            displayTable.stressbar = true
            previousData.stress.displayTime = gameTimer
        elseif forceDisplay.stressbar then
            displayTable.stressbar = true
            previousData.stress.displayTime = gameTimer
        else
            if previousData.stress.displayTime and previousData.stress.displayTime + Config.DisplayTime < gameTimer then
                displayTable.stressbar = false
                previousData.stress.displayTime = nil
            end
        end
    end,
    displayOxygen = function(v, gameTimer)
        if IsEntityInWater(PlayerPedId()) then
            displayTable.oxygenbar = true
            previousData.oxygen.displayTime = gameTimer
        elseif forceDisplay.oxygenbar then
            displayTable.oxygenbar = true
            previousData.oxygen.displayTime = gameTimer
        else
            if previousData.oxygen.displayTime and previousData.oxygen.displayTime + Config.DisplayTime < gameTimer then
                displayTable.oxygenbar = false
                previousData.oxygen.displayTime = nil
            end
        end
    end,
    displayVoice = function(v, gameTimer)
        if not previousData.voice.value then
            previousData.voice.value = v
        elseif v ~= previousData.voice.value then
            displayTable.voicebar = true
            previousData.voice.displayTime = gameTimer
            previousData.voice.value = v
        elseif forceDisplay.voicebar then
            displayTable.voicebar = true
            previousData.voice.displayTime = gameTimer
        else
            if previousData.voice.displayTime and previousData.voice.displayTime + Config.DisplayTime < gameTimer then
                displayTable.voicebar = false
                previousData.voice.displayTime = nil
            end
        end
    end,
}

RegisterCommand('spawned', function()
    playerSpawned = true
end, false)

RegisterNetEvent('unity-hud:cl_main:characterSpawned')
AddEventHandler('unity-hud:cl_main:characterSpawned', function()
    playerSpawned = true
end)

RegisterNUICallback('toggle', function(data, cb)
    forceDisplay[data.value] = data.currentIndex == -1 and true or false

    cb('ok')
end)

RegisterNUICallback('close', function(data, cb)
    SendNUIMessage({ type = 'SETTINGS_HIDE' })
    SetNuiFocus(false, false)
    cb('ok')
end)

RegisterCommand('hud', function()
    SendNUIMessage({
        type = 'SETTINGS_SHOW',
    })
    SetNuiFocus(true, true)
end, false)

Citizen.CreateThread(function()
    local sleep = 500

    while true do
        if playerSpawned then
            local tempTable = {}
            local playerPed = PlayerPedId()
            local isPedUnderwater = IsPedSwimmingUnderWater(playerPed)
            
            if not initialSpawn then
                SetPedMaxTimeUnderwater(playerPed, Config.MaxTimeUnderwater)
                initialSpawn = true
            end
    
            local playerHealth = GetEntityHealth(playerPed)
            tempTable.displayHealth = playerHealth > 101 and playerHealth - 100 or 0
    
            tempTable.playerArmor = GetPedArmour(playerPed)
    
            TriggerEvent('esx_status:getStatus', 'hunger', function(status)
                tempTable.playerHunger = (status.val / 1000) / 10
            end)
    
            TriggerEvent('esx_status:getStatus', 'thirst', function(status)
                tempTable.playerThirst = (status.val / 1000) / 10
            end)
    
            TriggerEvent('esx_status:getStatus', 'stress', function(status)
                tempTable.playerStress = (status.val / 1000) / 10
            end)
            
            if isPedUnderwater then
                timeRemainingUnderwater = timeRemainingUnderwater - subtractor
            else
                if timeRemainingUnderwater < Config.MaxTimeUnderwater then
                    SetPedMaxTimeUnderwater(playerPed, timeRemainingUnderwater)

                    local factor = nil
                    
                    if timeRemainingUnderwater < Config.MaxTimeUnderwater * 0.25 then
                        factor = airTable[1]
                    elseif timeRemainingUnderwater < Config.MaxTimeUnderwater * 0.50 then
                        factor = airTable[2]
                    elseif timeRemainingUnderwater < Config.MaxTimeUnderwater * 0.75 then
                        factor = airTable[3]
                    else
                        factor = airTable[4]
                    end

                    if timeRemainingUnderwater + factor >= Config.MaxTimeUnderwater then
                        timeRemainingUnderwater = Config.MaxTimeUnderwater
                    else
                        timeRemainingUnderwater = timeRemainingUnderwater + factor
                    end
                else
                    SetPedMaxTimeUnderwater(playerPed, Config.MaxTimeUnderwater)
                    timeRemainingUnderwater = Config.MaxTimeUnderwater
                end
            end

            tempTable.displayOxygen = timeRemainingUnderwater <= 0 and 0 or (timeRemainingUnderwater - 0) * 100 / (Config.MaxTimeUnderwater - 0)

            local voiceLevel = exports['mumble-voip']:GetPlayerVoiceLevel(GetPlayerServerId(PlayerId()))
            
            if voiceLevel == 1 then
                voiceLevel = 33
            elseif voiceLevel == 2 then
                voiceLevel = 66
            elseif voiceLevel == 3 then
                voiceLevel = 100
            end

            tempTable.displayVoice = voiceLevel

            bleedAmount, _ = exports['mythic_hospital']:getBleedStatus()

            local gameTimer = GetGameTimer()

            for k,v in pairs(tempTable) do
                displayActions[k](v, gameTimer)
            end

            SendNUIMessage({
                type = 'APP_DISPLAY',
                data = {
                    display = displayTable,
                }
            })

            for x,y in pairs(displayTable) do
                if y then
                    Citizen.Wait(250)

                    if isPedUnderwater then
                        timeRemainingUnderwater = timeRemainingUnderwater - 0.25
                    end

                    break
                end
            end

            SendNUIMessage({
                type = 'APP_UPDATE',
                data = {
                    healthbar = tempTable.displayHealth,
                    armorbar = tempTable.playerArmor,
                    foodbar = tempTable.playerHunger,
                    waterbar = tempTable.playerThirst,
                    stressbar = tempTable.playerStress,
                    oxygenbar = tempTable.displayOxygen,
                    voicebar = tempTable.displayVoice,
                    bleedAmount = bleedAmount,
                }
            })
        end

        Citizen.Wait(sleep)
    end
end)