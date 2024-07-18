function SendReactMessage(action, data)
    SendNUIMessage({
        action = action,
        data = data
    })
end

function RotationToDirection(rotation)
    local adjustedRotation = {
        x = (math.pi / 180) * rotation.x,
        y = (math.pi / 180) * rotation.y,
        z = (math.pi / 180) * rotation.z
    }

    local direction = {
        x = -math.sin(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)),
        y = math.cos(adjustedRotation.z) * math.abs(math.cos(adjustedRotation.x)),
        z = math.sin(adjustedRotation.x)
    }

    return direction
end

function EntityHit(startCoords, endCoords)
    local rayHandle = StartShapeTestRay(startCoords.x, startCoords.y, startCoords.z, endCoords.x, endCoords.y,
        endCoords.z, -1, PlayerPedId(), 0)
    local rayHandle, hit, endCoords, surfaceNormal, entityHit = GetShapeTestResult(rayHandle)

    return hit and entityHit or false
end

function RayCastGamePlayCamera(distance)
    local cameraRotation = GetGameplayCamRot()
    local cameraCoord = GetGameplayCamCoord()
    local direction = RotationToDirection(cameraRotation)

    local destination = {
        x = cameraCoord.x + direction.x * distance,
        y = cameraCoord.y + direction.y * distance,
        z = cameraCoord.z + direction.z * distance
    }

    return EntityHit({ x = cameraCoord.x, y = cameraCoord.y, z = cameraCoord.z },
        { x = destination.x, y = destination.y, z = destination.z })
end

function DrawCrosshair()
    DrawRect(0.5, 0.5, 0.008333333, 0.001851852, 255, 255, 255, 255);
    DrawRect(0.5, 0.5, 0.001041666, 0.014814814, 255, 255, 255, 255);
end

function HashToName(hash)
    local found = false

    for i = 1, #FoundObjects do
        if FoundObjects[i].HashIs == hash then
            found = FoundObjects[i].ModNam
            break
        end
    end

    return found or 'Unknown'
end

function PrintTable(node)
    local cache, stack, output = {}, {}, {}
    local depth = 1
    local output_str = "{\n"

    while true do
        local size = 0
        for k, v in pairs(node) do
            size = size + 1
        end

        local cur_index = 1
        for k, v in pairs(node) do
            if (cache[node] == nil) or (cur_index >= cache[node]) then
                if (string.find(output_str, "}", output_str:len())) then
                    output_str = output_str .. ",\n"
                elseif not (string.find(output_str, "\n", output_str:len())) then
                    output_str = output_str .. "\n"
                end

                table.insert(output, output_str)
                output_str = ""

                local key
                if (type(k) == "number" or type(k) == "boolean") then
                    key = "[" .. tostring(k) .. "]"
                else
                    key = "['" .. tostring(k) .. "']"
                end

                if (type(v) == "number" or type(v) == "boolean") then
                    output_str = output_str .. string.rep('\t', depth) .. key .. " = " .. tostring(v)
                elseif (type(v) == "table") then
                    output_str = output_str .. string.rep('\t', depth) .. key .. " = {\n"
                    table.insert(stack, node)
                    table.insert(stack, v)
                    cache[node] = cur_index + 1
                    break
                else
                    output_str = output_str .. string.rep('\t', depth) .. key .. " = '" .. tostring(v) .. "'"
                end

                if (cur_index == size) then
                    output_str = output_str .. "\n" .. string.rep('\t', depth - 1) .. "}"
                else
                    output_str = output_str .. ","
                end
            else
                if (cur_index == size) then
                    output_str = output_str .. "\n" .. string.rep('\t', depth - 1) .. "}"
                end
            end

            cur_index = cur_index + 1
        end

        if (size == 0) then
            output_str = output_str .. "\n" .. string.rep('\t', depth - 1) .. "}"
        end

        if (#stack > 0) then
            node = stack[#stack]
            stack[#stack] = nil
            depth = cache[node] == nil and depth + 1 or depth - 1
        else
            break
        end
    end

    table.insert(output, output_str)
    output_str = table.concat(output)

    print(output_str)
end

local isEntityDebuggerActive = false

RegisterCommand('+toggleEntityDebugger', function()
    if isEntityDebuggerActive then
        isEntityDebuggerActive = false

        SendReactMessage('setEntityDebuggerVisible', false)

        return
    end

    isEntityDebuggerActive = true

    CreateThread(function()
        while isEntityDebuggerActive do
            DrawCrosshair()

            -- Right click
            if IsControlJustPressed(2, 25) then
                local entity = RayCastGamePlayCamera(1000.0)

                if entity then
                    if IsEntityAPed(entity) or IsEntityAVehicle(entity) or IsEntityAnObject(entity) then
                        local qx, qy, qz, qw = GetEntityQuaternion(entity)

                        local default = {
                            entity = entity,
                            name = HashToName(GetEntityModel(entity)),
                            hash = GetEntityModel(entity),
                            coords = GetEntityCoords(entity),
                            distance = #(GetEntityCoords(PlayerPedId()).xy - GetEntityCoords(entity).xy),
                            heading = GetEntityPhysicsHeading(entity),
                            rotation = GetEntityRotation(entity, 2),
                            quaternion = { x = qx, y = qy, z = qz, w = qw },
                            isMission = IsEntityAMissionEntity(entity),
                            isNetworked = NetworkGetEntityIsNetworked(entity),
                        }

                        if default.isNetworked then
                            default.netOwner = GetPlayerServerId(NetworkGetEntityOwner(entity))
                            default.netHasControl = NetworkHasControlOfEntity(entity)
                            default.netID = NetworkGetNetworkIdFromEntity(entity)
                        end

                        if IsEntityAPed(entity) then
                            local extras = {
                                {
                                    label = 'HP',
                                    value = (
                                        tostring(GetEntityHealth(entity)) ..
                                        '/' .. tostring(GetEntityMaxHealth(entity)))
                                },
                                { label = 'Armor',       value = GetPedArmour(entity) },
                                { label = 'Group Index', value = GetPedGroupIndex(entity) },
                                { label = 'Group Hash',  value = GetPedRelationshipGroupHash(entity) },
                            }

                            SendReactMessage('setDebuggerData', { default = default, extras = extras })
                            SendReactMessage('setEntityDebuggerVisible', true)

                            PrintTable(extras)
                        elseif IsEntityAVehicle(entity) then
                            local extras = {
                                { label = 'Class',            value = GetVehicleClass(entity) },
                                { label = 'Body HP',          value = GetVehicleBodyHealth(entity) },
                                { label = 'Engine HP',        value = GetVehicleEngineHealth(entity) },
                                { label = 'Engine Temp',      value = GetVehicleEngineTemperature(entity) },
                                { label = 'Oil Level',        value = GetVehicleOilLevel(entity) },
                                { label = 'Fuel Level',       value = GetVehicleFuelLevel(entity) },
                                { label = 'Gas Tank HP',      value = GetVehiclePetrolTankHealth(entity) },
                                { label = 'Top Speed Mod',    value = GetVehicleTopSpeedModifier(entity) },
                                { label = 'Turbo Pressure',   value = GetVehicleTurboPressure(entity) },
                                { label = 'Previously Owned', value = IsVehiclePreviouslyOwnedByPlayer(entity) },
                                { label = 'Door Lock Status', value = GetVehicleDoorLockStatus(entity) },
                                { label = 'NTB Hotwired',     value = IsVehicleNeedsToBeHotwired(entity) },
                                { label = 'Alarm Set',        value = IsVehicleAlarmSet(entity) },
                                {
                                    label = 'Is Vehicle Running',
                                    value = GetIsVehicleEngineRunning(entity) == 1 and true or false
                                },
                            }

                            SendReactMessage('setDebuggerData', { default = default, extras = extras })
                            SendReactMessage('setEntityDebuggerVisible', true)

                            PrintTable(extras)
                        elseif IsEntityAnObject(entity) then
                            SendReactMessage('setDebuggerData', { default = default })
                            SendReactMessage('setEntityDebuggerVisible', true)
                        end
                    end
                end
            end

            -- Tilda
            if IsControlPressed(2, 243) then
                SetNuiFocus(true, true)
            end

            Wait(0)
        end
    end)
end, false)

RegisterCommand('-toggleEntityDebugger', function()
end, false)

RegisterKeyMapping('+toggleEntityDebugger', 'Toggle Entity Debugger', 'keyboard', 'F3')

RegisterNUICallback('giveControl', function(_, cb)
    cb(true)
    SetNuiFocus(false, false)
end)
