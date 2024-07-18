----------------
-- ESX NONSENSE
----------------
ESX = nil

Citizen.CreateThread(function()
  while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

-------------------
-- START OF SCRIPT
-------------------
local canSend911Alert = true

-------------
-- FUNCTIONS
-------------
-----------------------------------
-- Function to verify if player is
-- standing in front of a payphone
-----------------------------------
function verifyObject()
  local objectIsPayphone = false

  local entityHash = UnityHelper.GetEntityInFrontOfPlayer()

  if not entityHash then
    return false
  end

  for i=1, #Config.PayphoneModelHashes do
    if entityHash == Config.PayphoneModelHashes[i] then
      objectIsPayphone = true
    end
  end

  if objectIsPayphone then
    return true
  else
    return false
  end
end

-----------
-- THREADS
-----------
--------------------------------------
-- Main thread that creates payphones
-- and alters the chat suggestion
--------------------------------------
Citizen.CreateThread(function()
  UnityHelper.createPayphones()

  TriggerEvent('chat:addSuggestion', '/payphone', 'Start an anonymous phone call', {
    { name="phoneNumber", help="911 or 7 digit phone number | If 911, you must include a message" },
    { name="message", help="Anonymous message that should be sent to the Police" },
  })
end)

------------
-- COMMANDS
------------
---------------------------------------------------------
-- First this command checks if a player is standing
-- in front of a payphone, then it checks to see if
-- any arguements were provided, if they were, it checks
-- to see if the first arguement is 911 or a seven digit
-- phone number.
--
-- If the first arguement is 911, check to see if a
-- message was provided and if the message is above
-- Config.Minimum911MessageLength characters long,
-- prevent spam, then send the alert to police
--
-- If a seven digit phone number was provided, 
-- trigger server event to verify correct usage
---------------------------------------------------------
RegisterCommand('payphone', function(source, args, rawCommand)
  local isObjectAPayphone = verifyObject()

  if not isObjectAPayphone then
    exports['mythic_notify']:DoHudText('error', "You Are Not Close Enough To A Working Payphone")
    return
  end

  if not args[1] or args[1] ~= '911' and not args[1]:find("^%d%d%d%d%d%d%d$") then
    exports['mythic_notify']:DoHudText('error', "Please Enter A Valid Phone Number")
    return
  end
  
  if args[1] == '911' then
    if not args[2] then
      exports['mythic_notify']:DoHudText('error', "Please Enter A Message To Send")
      return
    elseif rawCommand:sub(14):len() < Config.Minimum911MessageLength then
      exports['mythic_notify']:DoHudText('error', "Message Must Be 20 Or More Characters")
      return
    end
    
    if canSend911Alert then
      canSend911Alert = false
      
      Citizen.SetTimeout(Config.PreventSpamTimer, function()
        canSend911Alert = true
      end)
      
      TriggerServerEvent('unity-payphones:send911Alert', rawCommand:sub(14))
    else
      exports['mythic_notify']:DoHudText('error', "You Must Wait Before Sending Another Call To 911")
    end

    return
  end

  TriggerServerEvent('unity-payphones:checkPhoneNumber', rawCommand:sub(10, 16))
end, false)

----------
-- EVENTS
----------
-----------------------------------------
-- Event to handle starting of anonymous
-- phone call after verification step
-----------------------------------------
RegisterNetEvent('unity-payphones:startAnonymousCall')
AddEventHandler('unity-payphones:startAnonymousCall', function(phoneNumber)
  local player               = PlayerPedId()
  local playerStartingCoords = GetEntityCoords(player)
  local anonymousCallLogged  = false
  local callTarget           = nil

  exports['unity-phone']:triggerPhoneCall(phoneNumber, true)

  Citizen.CreateThread(function()
    while true do
      local callStatus       = false
      local callbackFinished = false

      ESX.TriggerServerCallback('unity-payphones:checkCallStatus', function(status, target)
        if status then
          callStatus       = true
          callTarget       = target
          callbackFinished = true
        else
          callStatus       = false
          callbackFinished = true
        end
      end)

      if not callbackFinished then
        Citizen.Wait(500)
      end

      if not anonymousCallLogged then
        anonymousCallLogged = true
        TriggerServerEvent('unity-payphones:BigBrother', 'none', 'Anonymous Call Starting', nil, callTarget)
      end

      if not callStatus then
        TriggerServerEvent('unity-payphones:BigBrother', 'none', 'Anonymous Call Ending', nil, callTarget)
        break
      end

      local playerCurrentCoords = GetEntityCoords(player)
      
      if GetDistanceBetweenCoords(playerStartingCoords, playerCurrentCoords, false) > Config.MaxDistanceFromPayphone then
        exports['unity-phone']:endPhoneCall()
        exports['mythic_notify']:DoLongHudText('error', "You Must Stay Near The Payphone")
        TriggerServerEvent('unity-payphones:BigBrother', 'none', 'Anonymous Call Ending', nil, callTarget)
        break
      end

      Citizen.Wait(1000)
    end
  end)
end)

-- -----------------------------------------
-- -- TEMPORARY HELPER DURING DEVELOPMENT
-- -----------------------------------------
-- Citizen.CreateThread(function()
--   while true do
--     Citizen.Wait(0)

--     if IsControlJustReleased(0, 82) then
--       local entityHash = UnityHelper.GetEntityInFrontOfPlayer()

--       if entityHash then
--         TriggerEvent('chat:addMessage', {
--           color = {255, 0, 0},
--           args = { "Server", 'Object detected!'}
--         })
--       else
--         TriggerEvent('chat:addMessage', {
--           color = {255, 0, 0},
--           args = { "Server", "Unable to detect object!"}
--         })
--       end
--     end
--   end
-- end)