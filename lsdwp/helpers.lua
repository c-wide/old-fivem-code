WideHelper = {}

------------------------------
-- Helper function to create
-- vehicle provided the name
-- and coordinates. Fade in
-- and fade out, set vehicle
-- plate, then clean up and
-- return the vehicle created
------------------------------
WideHelper.renderVehicle = function(name, data)
    local x, y, z, heading = table.unpack(data)
    local randomNumbers = ''

    for i=1, 3 do
        local num = math.random(0, 9)
        randomNumbers = randomNumbers..num
    end

    RequestModel(name)

    while not HasModelLoaded(name) do
        Citizen.Wait(500)
    end

    DoScreenFadeOut(500)
    Citizen.Wait(500)

    local vehicle = CreateVehicle(name, x, y, z, heading, true, true)
    SetVehicleNumberPlateText(vehicle, Config.LicensePlateText..randomNumbers)

    SetPedIntoVehicle(PlayerPedId(), vehicle, -1)
    SetVehicleEngineOn(vehicle, true, true, true)
    
    Citizen.Wait(500)
    DoScreenFadeIn(500)

    SetModelAsNoLongerNeeded(name)

    return vehicle
end

---------------------------------
-- Helper function to delete
-- vehicle, fade in and fade out
---------------------------------
WideHelper.DeleteVehicle = function(vehicle)
    DoScreenFadeOut(500)
    Citizen.Wait(500)

    DeleteVehicle(vehicle)

    Citizen.Wait(500)
    DoScreenFadeIn(500)
end

-----------------------------
-- Helper function to trigger
-- progress bar. animation 
-- parameter can either be a 
-- string of a GTA Task name
-- or a table with animation
-- library and name provided
-----------------------------
WideHelper.ProgressBar = function(label, duration, animation, cb)
    local animationTable = nil

    if type(animation) == "table" then
        animationTable = animation
    else
        animationTable = {task = animation}
    end

    exports['mythic_progbar']:Progress({
        name = tostring(math.random(5, 20)),
        duration = duration,
        label = label,
        useWhileDead = false,
        canCancel = false,
        controlDisables = {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        },
        animation = animationTable,
    }, function(status)
        if not status then
            cb()
          end
    end)
end

--------------------------------------------
-- Helper function to render blip as needed
--------------------------------------------
WideHelper.renderBlip = function(name, coords, sprite, color, scale, shortRange)
    local blip = AddBlipForCoord(coords)

    SetBlipSprite(blip, sprite)
    SetBlipColour(blip, color)
    SetBlipScale(blip, scale)
    SetBlipAsShortRange(blip, shortRange)

    BeginTextCommandSetBlipName('STRING')
    AddTextComponentSubstringPlayerName(name)
    EndTextCommandSetBlipName(blip)

    return blip
end

----------------------------------------------
-- Helper function to draw 3D Text on screen
----------------------------------------------
WideHelper.Draw3DText = function(coords, text)
    local x, y, z = table.unpack(coords)
    Unity.Utils.DrawText(x, y, z, text)
end

------------------------------
-- Helper function to raycast
-- in front of player then 
-- return an entity hash and
-- entity coordinates
------------------------------
WideHelper.GetEntitiyInFrontOfPlayer = function()
    local player       = PlayerPedId()
    local playerCoords = GetEntityCoords(player)
    local offset       = GetOffsetFromEntityInWorldCoords(player, 0.0, Config.RayCastDistance, 0.0)
    local entityHash   = nil
    local entityCoords = nil

    local resultInteger, didHit, endCoords, surfaceNormal, entity = GetShapeTestResult(StartShapeTestRay(playerCoords, offset, -1, -1, -1))

    if GetEntityType(entity) == 3 then
        entityHash = GetEntityModel(entity)
        entityCoords = GetEntityCoords(entity)
    end

    return entityHash, entityCoords
end

-- -----------------------------------------
-- -- TEMPORARY HELPER DURING DEVELOPMENT
-- -----------------------------------------
-- WideHelper.saveObject = function(distance)
--     local player       = PlayerPedId()
--     local playerCoords = GetEntityCoords(player)
--     local offset       = GetOffsetFromEntityInWorldCoords(player, 0.0, distance, 0.0)
--     local entityHash   = nil
--     local entityCoords = nil

--     local resultInteger, didHit, endCoords, surfaceNormal, entity = GetShapeTestResult(StartShapeTestRay(playerCoords, offset, -1, -1, -1))

--     if GetEntityType(entity) == 3 then
--         entityHash = GetEntityModel(entity)
--         entityCoords = GetEntityCoords(entity)
--     end

--     return entityHash, entityCoords
-- end