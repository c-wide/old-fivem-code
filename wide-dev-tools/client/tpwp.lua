RegisterCommand('+tpwp', function()
    local success = false
    local entity = PlayerPedId()

    local blipFound = false
    local blipIterator = GetBlipInfoIdIterator()
    local blip = GetFirstBlipInfoId(8)

    while DoesBlipExist(blip) do
        if GetBlipInfoIdType(blip) == 4 then
            cx, cy, cz = table.unpack(Citizen.InvokeNative(0xFA7C7F0AADF25D09, blip, Citizen.ReturnResultAnyway(),
                Citizen.ResultAsVector())) --GetBlipInfoIdCoord(blip)
            blipFound = true
            success = true
            break
        end
        blip = GetNextBlipInfoId(blipIterator)
    end

    if blipFound then
        local groundFound = false
        local yaw = GetEntityHeading(entity)

        for i = 0, 1000, 1 do
            SetEntityCoordsNoOffset(entity, cx, cy, ToFloat(i), false, false, false)
            SetEntityRotation(entity, 0, 0, 0, 0, 0)
            SetEntityHeading(entity, yaw)
            SetGameplayCamRelativeHeading(0)
            Citizen.Wait(0)
            if GetGroundZFor_3dCoord(cx, cy, ToFloat(i), cz, false) then
                cz = ToFloat(i)
                groundFound = true
                break
            end
        end
        if not groundFound then
            cz = -300.0
        end
        success = true
    else
        print('you must place a waypoint first.')
    end

    if success then
        SetEntityCoordsNoOffset(entity, cx, cy, cz, false, false, true)
        SetGameplayCamRelativeHeading(0)
        blipFound = false
    end
end, false)

RegisterCommand('-tpwp', function()
end, false)

RegisterKeyMapping('+tpwp', 'Teleport to Waypoint', 'keyboard', 'F7')
