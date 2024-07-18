local isNoClipEnabled = false
local noClipCam = nil

RegisterCommand('+toggleNoClip', function()
    if isNoClipEnabled then
        local playerPed = PlayerPedId()

        DestroyAllCams(true)
        RenderScriptCams(false, true, 1, true, true)

        FreezeEntityPosition(playerPed, false)
        SetEntityCollision(playerPed, true, true)
        SetEntityInvincible(playerPed, false)
        SetEveryoneIgnorePlayer(playerPed, false)
        SetPoliceIgnorePlayer(playerPed, false)
        NetworkSetEntityInvisibleToNetwork(playerPed, false)
        SetEntityVisible(playerPed, true, true)

        isNoClipEnabled = false
    else
        local playerPed = PlayerPedId()
        local camRot = GetGameplayCamRot(0)

        noClipCam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
        SetCamActive(noClipCam, true)
        RenderScriptCams(true, false, 1, true, true)
        AttachCamToPedBone(noClipCam, playerPed, 31086, 0.0, 0.0, 0.0, 0.0)
        SetCamRot(noClipCam, camRot, 2)

        FreezeEntityPosition(playerPed, true)
        SetEntityCollision(playerPed, false, false)
        SetEntityInvincible(playerPed, true)
        SetEveryoneIgnorePlayer(playerPed, true)
        SetPoliceIgnorePlayer(playerPed, true)
        NetworkSetEntityInvisibleToNetwork(playerPed, true)
        SetEntityVisible(playerPed, false, true)
        ClearPedTasksImmediately(playerPed)

        isNoClipEnabled = true

        CreateThread(function()
            while isNoClipEnabled do
                local rightAxisX = GetDisabledControlNormal(0, 220)
                local rightAxisY = GetDisabledControlNormal(0, 221)

                local x, y, z = table.unpack(GetGameplayCamRot(0))

                z = z + rightAxisX * -10.0

                local yValue = rightAxisY * -5.0

                if x + yValue > -89.0 and x + yValue < 89.0 then
                    x = x + yValue
                end

                SetCamRot(noClipCam, x, y, z, 2)

                Wait(0)
            end
        end)

        CreateThread(function()
            local speed = 1.0
            local maxSpeed = 32.0

            while isNoClipEnabled do
                local multiplier = 1.0

                if IsDisabledControlPressed(2, 15) then
                    speed = math.min(speed + 0.1, maxSpeed)
                elseif IsDisabledControlPressed(2, 14) then
                    speed = math.max(0.1, speed - 0.1)
                end

                if IsControlPressed(2, 209) then
                    multiplier = 2.0
                elseif IsControlPressed(2, 19) then
                    multiplier = 4.0
                elseif IsControlPressed(2, 36) then
                    multiplier = 0.25
                end

                local playerPed = PlayerPedId()
                local playerCoords = GetEntityCoords(playerPed)
                local rightV, forwardV, upV, pos = GetCamMatrix(noClipCam)

                if IsControlPressed(2, 32) then
                    SetEntityCoordsNoOffset(playerPed, (playerCoords + forwardV * (speed * multiplier)), 0.0, 0.0,
                        0.0)
                elseif IsControlPressed(2, 33) then
                    SetEntityCoordsNoOffset(playerPed, (playerCoords - forwardV * (speed * multiplier)), 0.0, 0.0,
                        0.0)
                end

                if IsControlPressed(2, 34) then
                    local pos = GetOffsetFromEntityInWorldCoords(playerPed, vector3(-speed * multiplier, 0.0, 0.0))
                    SetEntityCoordsNoOffset(playerPed, vector3(pos.x, pos.y, playerCoords.z), 0.0, 0.0, 0.0)
                elseif IsControlPressed(2, 35) then
                    local pos = GetOffsetFromEntityInWorldCoords(playerPed, vector3(speed * multiplier, 0.0, 0.0))
                    SetEntityCoordsNoOffset(playerPed, vector3(pos.x, pos.y, playerCoords.z), 0.0, 0.0, 0.0)
                end

                if IsControlPressed(2, 52) then
                    SetEntityCoordsNoOffset(playerPed,
                        GetOffsetFromEntityInWorldCoords(playerPed, vector3(0.0, 0.0, multiplier * speed / 2)), 0.0,
                        0.0, 0.0)
                end

                if IsControlPressed(2, 51) then
                    SetEntityCoordsNoOffset(playerPed,
                        GetOffsetFromEntityInWorldCoords(playerPed, vector3(0.0, 0.0, multiplier * -speed / 2)), 0.0
                        , 0.0, 0.0)
                end

                DisablePlayerFiring(playerPed, true)

                SetEntityHeading(playerPed, math.max(0.0, (360 + GetCamRot(noClipCam, 2).z) % 360.0))

                Wait(0)
            end
        end)

    end
end, false)

RegisterCommand('-toggleNoClip', function()
end, false)

RegisterKeyMapping('+toggleNoClip', 'Toggle No Clip', 'keyboard', 'F2')
