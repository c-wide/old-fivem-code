UnityHelper = {}

----------------------------------------------
-- Helper function to draw 3D Text on screen
----------------------------------------------
UnityHelper.Draw3DText = function(coords, text)
    local x, y, z = table.unpack(coords)
    Unity.Utils.DrawText(x, y, z+1.20, text)
end

------------------------------------------------------
-- Helper function to raycast in front of player then 
-- return an entity hash and entity coordinates
------------------------------------------------------
UnityHelper.Raycast = function()
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