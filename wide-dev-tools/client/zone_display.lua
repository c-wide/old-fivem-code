local isShowing = false

RegisterCommand('+toggleZoneDisplay', function()
    isShowing = not isShowing

    if not isShowing then
        SendReactMessage('setZoneDisplayVisible', false)
        return
    end

    CreateThread(function()
        while isShowing do
            SendReactMessage('setZoneName', GetNameOfZone(GetEntityCoords(PlayerPedId())))
            Wait(100)
        end
    end)

    SendReactMessage('setZoneDisplayVisible', true)
end, false)

RegisterKeyMapping('+toggleZoneDisplay', 'Toggle Zone Display', 'keyboard', 'HOME')
