UnityHelper = {}

----------------------------------------
-- Helper function to raycast in front 
-- of player then return an entity hash
----------------------------------------
UnityHelper.GetEntityInFrontOfPlayer = function()
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

------------------------------------------------------
-- Helper function to spawn payphones at script start
------------------------------------------------------
UnityHelper.createPayphones = function()
    Citizen.CreateThread(function()
        for i=1, #Config.PayphoneSpawnLocations do
            RequestModel(Config.PayphoneSpawnLocations[i].ModelName)

            while not HasModelLoaded(Config.PayphoneSpawnLocations[i].ModelName) do
                Citizen.Wait(500)			
            end

			for j=1, #Config.PayphoneSpawnLocations[i].SpawnLocations do
                local object = CreateObjectNoOffset(Config.PayphoneSpawnLocations[i].ModelName, Config.PayphoneSpawnLocations[i].SpawnLocations[j].x, Config.PayphoneSpawnLocations[i].SpawnLocations[j].y, Config.PayphoneSpawnLocations[i].SpawnLocations[j].z, false, false, false)
                SetEntityHeading(object, Config.PayphoneSpawnLocations[i].SpawnLocations[j].heading)
				FreezeEntityPosition(object,true)
            end
            
            SetModelAsNoLongerNeeded(Config.PayphoneSpawnLocations[i].ModelName)
        end
    end)
end