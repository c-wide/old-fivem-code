----------------
-- ESX NONSENSE
----------------
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

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  ESX.PlayerData = xPlayer   
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  ESX.PlayerData.job = job
end)

----------------
-- SCRIPT START
----------------
local numOfCopsOnline      = 0
local robberyInProgress    = false
local isHittingATM         = false
local showBeginRobberyText = false
local entityHash           = nil
local entityCoords         = nil
local cameraActive         = false
local playerGender         = nil
local attachedPropPhone    = nil

-------------
-- FUNCTIONS
-------------
----------------------------------------------------
-- Function to initiate hitting of ATM after server
-- verification. Play the animation, after X amount
-- of time break into the ATM. This function also
-- handles playing sound while hitting the ATM.
----------------------------------------------------
function startHittingATM(xEntityCoords)
    Citizen.CreateThread(function()
        while not HasAnimDictLoaded(Config.SwingAnimDict) do
            RequestAnimDict(Config.SwingAnimDict)
            Citizen.Wait(5)
        end

        local animDuration = GetAnimDuration(Config.SwingAnimDict, Config.SwingAnimName)

        TaskPlayAnim(PlayerPedId(), Config.SwingAnimDict, Config.SwingAnimName, 8.0, 8.0, animDuration, 1, 1, false, false, false)

        local timer = math.random(Config.MinBreakInTime, Config.MaxBreakInTime)

        Citizen.SetTimeout(timer * 1000, function()
            if robberyInProgress then
                isHittingATM = false
                SetCurrentPedWeapon(PlayerPedId(), GetHashKey('WEAPON_UNARMED'), true)
                Citizen.Wait(3000)
                startStealingCash(xEntityCoords)
                return  
            end
        end)

        isHittingATM = true
        local firstHit = true

        while isHittingATM do
            if firstHit then
                Citizen.Wait(500)

                if isHittingATM then
                    TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 10.0, 'hitmetal', 0.5)
                end
            end

            if not firstHit then
                Citizen.Wait(1600)

                if isHittingATM then
                    TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 10.0, 'hitmetal', 0.5)
                end
            end

            firstHit = false
        end

        return
    end)
end

-----------------------------------------------------
-- Function to initiate stealing of money from 
-- the ATM. Play the animation, while the robbery
-- is in progress, steal cash every X amount of time
-----------------------------------------------------
function startStealingCash(xEntityCoords)
    Citizen.CreateThread(function()
        while not HasAnimDictLoaded(Config.StealAnimDict) do
            RequestAnimDict(Config.StealAnimDict)
            Citizen.Wait(5)
        end

        local animDuration = GetAnimDuration(Config.StealAnimDict, Config.StealAnimName)

        TaskPlayAnim(PlayerPedId(), Config.StealAnimDict, Config.StealAnimName, 8.0, 8.0, animDuration, 1, 1, false, false, false)

        while robberyInProgress do
            TriggerServerEvent('unity-robatm:stealCash', xEntityCoords)

            Citizen.Wait(Config.StealCashInterval)
        end
    end)
end


-----------------------------------------
-- Function to get a players coordinates 
-- and current street name
-----------------------------------------
function getLocation()
    local coords        = GetEntityCoords(PlayerPedId())
    local streetName, _ = GetStreetNameAtCoord(coords.x, coords.y, coords.z)
    local streetName    = GetStreetNameFromHashKey(streetName)

    return coords, streetName
end

--------------------------------------------
-- Function to get a players gender integer
--------------------------------------------
function getGender()
    playerGender = nil

    while playerGender == nil do
        TriggerEvent('skinchanger:getSkin', function(skin)
            playerGender = skin.sex
        end)

        Citizen.Wait(0)
    end
end

------------------------------------------
-- Function to delete tablet if it exists
------------------------------------------
function removeAttachedPropPhone()
    if DoesEntityExist(attachedPropPhone) then
      DeleteEntity(attachedPropPhone)
      attachedPropPhone = nil
    end
end

-----------
-- THREADS
-----------
---------------------------------------------------- 
-- Thread to handle if the begin robbery text
-- should show up. If player is already robbing
-- an ATM, sleep. Check if the ped is armed with
-- the correct weapon, if so raycast in front of 
-- the player. If ATM, check if its a robbable ATM,
-- if so display the begin robbery text
---------------------------------------------------- 
Citizen.CreateThread(function()
    while true do
        local playerPedId = PlayerPedId()
        local sleep       = 1000

        if robberyInProgress then
            showBeginRobberyText = false
            goto continue
        end

        if IsPedArmed(playerPedId, 1) then
            local weaponHash      = GetSelectedPedWeapon(playerPedId)
            local isCorrectWeapon = false

            for i=1, #Config.WeaponHashes do
                if Config.WeaponHashes[i] == weaponHash then
                    isCorrectWeapon = true
                end
            end

            if isCorrectWeapon then
                entityHash, entityCoords = UnityHelper.Raycast()

                if entityHash then
                    local isRobbableATM = false

                    for j=1, #Config.ATMLocations do
                        if Config.ATMLocations[j].hash == entityHash then
                            for k=1, #Config.ATMLocations[j].locations do
                                if tostring(Config.ATMLocations[j].locations[k].vector) == tostring(entityCoords) then
                                    isRobbableATM = true
                                end
                            end
                            goto ATMCheckCompleted
                        end
                    end

                    ::ATMCheckCompleted::

                    if isRobbableATM then
                        sleep                = 100
                        showBeginRobberyText = true
                        goto continue
                    end
                end
            end
        end

        showBeginRobberyText = false

        ::continue::
        Citizen.Wait(sleep)
    end
end)

------------------------------------------------------
-- Thread to handle actually showing the begin
-- robbery text. Separate threads because I dont
-- want to raycast every second. This thread also
-- handles showing the quit early text and quitting
-- if correct button is pressed. If somehow you get
-- a bad entity after beginning robbery, safely error
-- out. If you die, get injured, or move too far away
-- from ATM during robbery, safely error out. 
------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        local sleep = 500

        if showBeginRobberyText then
            sleep = 0

            UnityHelper.Draw3DText(entityCoords, Config.InputKeyLabel..' Begin Robbery')

            if IsControlJustReleased(0, Config.InputKey) then
                if IsPedInAnyVehicle(PlayerPedId(), false) then
                    exports['mythic_notify']:DoHudText('error', "You Must Be On Foot To Begin Robbery")
                    goto continue
                end
                getGender()
                TriggerServerEvent('unity-robatm:attemptRobbery', entityCoords, numOfCopsOnline)
            end
        end

        if robberyInProgress then
            sleep = 0
            local playerPedId = PlayerPedId()

            if entityCoords == nil then
                exports['mythic_notify']:DoHudText('error', "An Error Has Occurred, Cancelling...")
                ClearPedTasksImmediately(playerPedId)
                robberyInProgress = false
                isHittingATM      = false
            end

            if HasEntityBeenDamagedByWeapon(playerPedId, 0, 2) or IsEntityDead(playerPedId) or GetDistanceBetweenCoords(GetEntityCoords(playerPedId, false), entityCoords, false) > Config.ForceQuitDistance then
                exports['mythic_notify']:DoHudText('error', "You've Been Injured Or Left The Area")
                ClearPedTasksImmediately(playerPedId)
                robberyInProgress = false
                isHittingATM      = false
            end

            UnityHelper.Draw3DText(entityCoords, Config.InputKeyLabel..' Stop Robbery')

            if IsControlJustReleased(0, Config.InputKey) then
                ClearPedTasksImmediately(playerPedId)
                robberyInProgress = false
                isHittingATM      = false
            end
        end 

        ::continue::
        Citizen.Wait(sleep)
    end
end)

----------
-- EVENTS
----------
---------------------------------------------------------
-- Event to handle getting # of cops online every minute
---------------------------------------------------------
RegisterNetEvent('unity_robatm:getNumOfCopsOnline')
AddEventHandler('unity_robatm:getNumOfCopsOnline', function(amount)
    numOfCopsOnline = amount
end)

------------------------------------------------------------------
-- Event to handle beginning robbery after server verification
-- Also clears last weapon damage for during robbery damage check
------------------------------------------------------------------
RegisterNetEvent('unity-robatm:beginRobbery')
AddEventHandler('unity-robatm:beginRobbery', function(xEntityCoords, atmIndex)
    local coords, streetName = getLocation()

    ClearEntityLastWeaponDamage(PlayerPedId())

    TriggerServerEvent('esx_outlawalert:ATMRobberyInProgress', coords, streetName, playerGender, atmIndex)

    robberyInProgress = true

    startHittingATM(xEntityCoords)
end)

--------------------------------------
-- Event to handle when a player has
-- stolen all of the money in an ATM. 
--------------------------------------
RegisterNetEvent('unity-robatm:ATMPocketsCleaned')
AddEventHandler('unity-robatm:ATMPocketsCleaned', function()
    ClearPedTasksImmediately(PlayerPedId())
    robberyInProgress = false
end)

---------------------------------------------------------
-- Event to handle setting up ATM Camera after server
-- verification. Sets up camera and effects, attaches
-- a tablet and starts animation. Disables controls 
-- while in camera. Once done, clean up & destroy camera
---------------------------------------------------------
RegisterNetEvent('unity-robatm:setATMCam')
AddEventHandler('unity-robatm:setATMCam', function(camCoords, camHeading)
    local x, y, z     = table.unpack(camCoords)
    local atmCam      = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
    local playerPedId = PlayerPedId()

    SetCamFov(atmCam, 90.0)
    SetCamCoord(atmCam, x, y, z+1.60)
    SetCamRot(atmCam, 0.0, 0.0, camHeading)

    RenderScriptCams(true, true, 3, 1, 0)
    SetFocusPosAndVel(camCoords, 0.0, 0.0, 0.0)
    SetTimecycleModifier("scanline_cam_cheap")
    SetTimecycleModifierStrength(2.0)

    cameraActive = true

    TriggerEvent("unity-robatm:attachItemPhone","tablet01")

    while cameraActive do
        while not HasAnimDictLoaded(Config.TabletAnimDict) do
            RequestAnimDict(Config.TabletAnimDict)
            Citizen.Wait(5)
        end

        local animDuration = GetAnimDuration(Config.TabletAnimDict, Config.TabletAnimName)

        if not IsEntityPlayingAnim(playerPedId, Config.TabletAnimDict, Config.TabletAnimName, 3) then
            TaskPlayAnim(playerPedId, Config.TabletAnimDict, Config.TabletAnimName, 3.0, 3.0, -1, 49, 0, 0, 0, 0)
        end

        DisableAllControlActions(0)
        EnableControlAction(0, 245, true)
        EnableControlAction(0, 137, true)
        EnableControlAction(0, 19, true)

        Citizen.Wait(0)
    end

    RenderScriptCams(false, false, 0, 1, 0)
    SetFocusEntity(playerPedId)
    ClearTimecycleModifier("scanline_cam_cheap")
    EnableAllControlActions(0)
    TriggerEvent('unity-robatm:destroyPropPhone')
    ClearPedSecondaryTask(PlayerPedId())
    DestroyCam(atmCam)
end)

-------------------------------------------
-- Event to trigger attaching phone to ped
-------------------------------------------
RegisterNetEvent("unity-robatm:attachItemPhone")
AddEventHandler("unity-robatm:attachItemPhone", function(item)
  TriggerEvent("unity-robatm:attachPropPhone", Config.AttachPropList[item]["model"], Config.AttachPropList[item]["bone"], Config.AttachPropList[item]["x"], Config.AttachPropList[item]["y"], Config.AttachPropList[item]["z"], Config.AttachPropList[item]["xR"], Config.AttachPropList[item]["yR"], Config.AttachPropList[item]["zR"])
end)

-------------------------------------------
-- Event to handle attaching phone to ped
--            Thank you Ben :D
-------------------------------------------
RegisterNetEvent("unity-robatm:attachPropPhone")
AddEventHandler("unity-robatm:attachPropPhone", function(attachModelSent,boneNumberSent,x,y,z,xR,yR,zR)
  removeAttachedPropPhone()
  local attachModelPhone = GetHashKey(attachModelSent)
  SetCurrentPedWeapon(GetPlayerPed(-1), 0xA2719263) 
  local bone = GetPedBoneIndex(GetPlayerPed(-1), boneNumberSent)
  RequestModel(attachModelPhone)
  while not HasModelLoaded(attachModelPhone) do
    Citizen.Wait(100)
  end
  attachedPropPhone = CreateObject(attachModelPhone, 1.0, 1.0, 1.0, 1, 1, 0)
  AttachEntityToEntity(attachedPropPhone, GetPlayerPed(-1), bone, x, y, z, xR, yR, zR, 1, 0, 0, 0, 2, 1)
end)

-----------------------------------
-- Event to handle deleting tablet
-----------------------------------
RegisterNetEvent('unity-robatm:destroyPropPhone')
AddEventHandler('unity-robatm:destroyPropPhone', function()
  removeAttachedPropPhone()
end)

-----------------------------------------------------------
-- ATM Command, checks if user is an on-duty officer,
-- if no args, if in a camera, exit otherwise show
-- active camera list. /[command] [index] to view camera
-- if available, /[command] [index] [checkCommandName] to
-- check how much money has been stolen. Also a help
-- command, /[command] [helpCommandName] for instructions
-----------------------------------------------------------
RegisterCommand(Config.ATMCamCommandName, function(source, args)
    if ESX.PlayerData.job.name ~= Config.PoliceJobName then
        exports['mythic_notify']:DoHudText('error', "Unauthorized User")
        return
    end

    if #args == 0 then
        if cameraActive then
            cameraActive = false
        else
            TriggerServerEvent('unity-robatm:getCamIndicies')
        end

        return
    end

    if #args > 1 and args[2] ~= Config.ATMCheckCommandName then
        exports['mythic_notify']:DoHudText('error', "Incorrect Command Usage")
        return
    end

    if args[2] then
        TriggerServerEvent('unity-robatm:checkStolenAmount', args[1])
        return
    end

    if args[1] == Config.ATMHelpCommandName then
        TriggerServerEvent('unity-robatm:displayHelpText')
        return
    end

    TriggerServerEvent('unity-robatm:attemptATMCam', args[1])
end, false)

TriggerEvent('chat:addSuggestion', '/'..Config.ATMCamCommandName, 'Police ATM Functionality', {
    { name="help", help="Display ATM Help Text" }
})