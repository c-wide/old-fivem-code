-----------------------
-- BEGINNING OF SCRIPT
-----------------------
local OFFDUTY, ONDUTY, ENROUTE, ONSITE, COOP = 0, 1, 2, 3, 4

local spawnVehicleKeyPressed = false
local playerState            = OFFDUTY
local currentJob             = nil
local jobVehicle             = nil
local parentId               = nil
local childId                = nil
local taskInProgress         = nil
local canQueryTasks          = true
local onsiteTasks            = {}
local blips                  = {}
Unity                        = nil

-------------
-- FUNCTIONS
-------------
--------------------------------------------
-- If player's state is OFFDUTY then check
-- if player is within marker draw distance
-- if so, draw marker, check if player is 
-- close enough to trigger job start, check
-- if player triggers job start event
-- if not, sleep thread
--------------------------------------------
function offDuty()
  local player                      = PlayerPedId()
  local playerCoords                = GetEntityCoords(player)
  local playerDistanceFromDutyStart = GetDistanceBetweenCoords(playerCoords, Config.DutyStartLocation, false)

  if playerDistanceFromDutyStart < Config.DutyStartMarkerDrawDistance then
    WideHelper.Draw3DText(Config.DutyStartLocation, Config.InputKeyLabel..' To Start')

    if playerDistanceFromDutyStart < Config.DutyStartInputKeyUseDistance then
      if IsControlJustReleased(0, Config.InputKey) then
        if IsPedInAnyVehicle(player, false) then
          exports['mythic_notify']:DoHudText('error', 'Please Leave Your Vehicle To Begin')
          return
        end

        if not spawnVehicleKeyPressed then
          TriggerServerEvent('lsdwp:startJob')
          spawnVehicleKeyPressed = true
        end
        Citizen.Wait(1000)
      end
    end
  else
    Citizen.Wait(1000)
  end
end

------------------------------------------------
-- If playerState is ONDUTY then 
-- assign a job randomly, make sure its
-- not the same job as the previous job
-- set a blip & route, change state to ENROUTE
-- If co-op player exists, send new job to them
------------------------------------------------
function onDuty()
  local previousJob = currentJob or nil

  if previousJob then
    while previousJob == currentJob do
      currentJob = Config.Locations[math.random(1, #Config.Locations)]
    end
  else
    currentJob = Config.Locations[math.random(1, #Config.Locations)]
  end

  if childId then
    TriggerServerEvent('lsdwp:sendJobInfo', currentJob, childId)
  end

  setRouteBlip()

  exports['mythic_notify']:DoLongHudText('inform', 'Please Head To The Assigned Job')

  playerState = ENROUTE
end

------------------------------------------------
-- If playerState is ENROUTE then check
-- if player is in their job vehicle and
-- if they're close enough to the anchor
-- point, once arrived and in job vehicle
-- clean up route blip & route then
-- assign a random number of tasks to the
-- player, making sure they're unique, then
-- create blips and insert both into tables.
-- If co-op player exists, remove their blip 
-- upon arrival and send them the new task list
------------------------------------------------
function enRoute()
  local player       = PlayerPedId()
  local playerCoords = GetEntityCoords(player)
  local vehicle = GetVehiclePedIsIn(player, false)

  if GetEntityModel(vehicle) == Config.VehicleHash and GetDistanceBetweenCoords(playerCoords, currentJob.AnchorPoint) < Config.JobSiteAnchorPointCheckDistance then
    removeRouteBlip()

    if childId then
      TriggerServerEvent('lsdwp:triggerRemoveChildJobBlip', childId)
    end

    for i=1, math.random(1, currentJob.MaxTasks) do
      local randomTask = currentJob.ObjectLocations[math.random(1, #currentJob.ObjectLocations)]

      for j=1, #onsiteTasks do
        if tostring(randomTask) == tostring(onsiteTasks[j]) then
          i = i - 1
          goto continue
        end
      end

      local blip = WideHelper.renderBlip(Config.BlipDetails.Task.name, randomTask, Config.BlipDetails.Task.sprite, Config.BlipDetails.Task.color, Config.BlipDetails.Task.scale, true)

      table.insert(onsiteTasks, randomTask)
      table.insert(blips, {blipId = blip, blipLocation = randomTask})

      ::continue::
    end

    if childId then
      TriggerServerEvent('lsdwp:updateTasks', onsiteTasks, childId, currentJob)
    end

    playerState = ONSITE
  else
    Citizen.Wait(1000)
  end
end

-----------------------------------------------------
-- If playerState is ONSITE then check
-- if the player is near any of the task
-- markers. If so, show marker and distance
-- check for input key. If player hits the 
-- input key, raycast in front of player to
-- retrieve the object they're facings hash and
-- coordinates. If the ray retrieved an object
-- compare the coordinates to the current tasks.
-- If the coords exist in task list, select a 
-- random animation assigned to that object
-- using the object hash as an identifier. Then
-- trigger the progress bar with that animation.
-- Callback triggers server event to payout.
-- Remove the blip and task from the table.
-- Check if task list is empty, if so, set
-- playerState to ONDUTY.
-- If co-op player exists perform checks to prevent
-- douchebaggery and update target clients on action
-----------------------------------------------------
function onSite()
  local player        = PlayerPedId()
  local playerCoords  = GetEntityCoords(player)
  local nearMarker    = false
  local drawnMarkers  = {}
  local target        = parentId or childId

  for i=1, #onsiteTasks do
    if GetDistanceBetweenCoords(playerCoords, onsiteTasks[i]) < Config.JobSiteMarkerDrawDistance then
      nearMarker = true
      table.insert(drawnMarkers, onsiteTasks[i])
    end
  end

  if nearMarker then
    for j=1, #drawnMarkers do
      local x, y, z = table.unpack(drawnMarkers[j])
      z = z + 1.11
      WideHelper.Draw3DText(vector3(x, y, z), Config.InputKeyLabel..' To Repair')

      if GetDistanceBetweenCoords(playerCoords, drawnMarkers[j]) < Config.JobSiteInputKeyUseDistance then
        if IsControlJustReleased(0, Config.InputKey) then
          if IsPedInAnyVehicle(player, false) then
            exports['mythic_notify']:DoHudText('error', 'Really Bro?')
            return
          end

          local entityHash, entityCoords = WideHelper.GetEntitiyInFrontOfPlayer()
          local correctObject            = nil
          
          if entityCoords then
            local entityCoordsString = tostring(entityCoords)

            for k=1, #onsiteTasks do
              if entityCoordsString == tostring(onsiteTasks[k]) then
                correctObject = k
              end
            end

            if correctObject then
              if target then
                if taskInProgress then
                  if entityCoordsString == taskInProgress then
                    exports['mythic_notify']:DoHudText('error', "Machine Already Being Repaired")
                    return
                  end
                end
                TriggerServerEvent('lsdwp:triggerSetTaskInProgress', entityCoordsString, target)
              end

              for l=1, #currentJob.Objects do
                if entityHash == currentJob.Objects[l].hash then
                  local randomAnimation = currentJob.Objects[l].animations[math.random(1, #currentJob.Objects[l].animations)]

                  WideHelper.ProgressBar(Config.ProgressBarLabel, Config.ProgressBarDuration, randomAnimation, function() 
                    if target then
                      if taskInProgress then
                        if entityCoordsString == taskInProgress then
                          exports['mythic_notify']:DoHudText('error', "Really Bro?")
                          return
                        end
                      end
                    end
                    TriggerServerEvent('lsdwp:triggerPayout', target)
                  end)

                  Citizen.Wait(Config.ProgressBarDuration)

                  for m=1, #blips do
                    if blips[m].blipLocation then
                      if entityCoordsString == tostring(blips[m].blipLocation) then
                        if target then
                          TriggerServerEvent('lsdwp:triggerRemoveTaskBlip', blips[m].blipLocation, target)
                        end
                        RemoveBlip(blips[m].blipId)
                      end
                    end
                  end
                  if target then
                    TriggerServerEvent('lsdwp:triggerRemoveTask', entityCoordsString, target)
                  end

                  while true do
                    Citizen.Wait(0)
                    
                    if not canQueryTasks then
                      Citizen.Wait(500)
                    end

                    canQueryTasks = false

                    for n=1, #onsiteTasks do
                      if entityCoordsString == tostring(onsiteTasks[n]) then
                        table.remove(onsiteTasks, n)
                      end
                    end

                    canQueryTasks = true
                    break
                  end
                end
              end
            else
              exports['mythic_notify']:DoHudText('error', 'Please Get Closer Or Face The Machine')
            end
          else
            exports['mythic_notify']:DoHudText('error', 'Please Get Closer Or Face The Machine')
          end
        end
      end
    end
  else
    Citizen.Wait(1000)
  end

  if playerState == ONSITE and #onsiteTasks <= 0 then
    if parentId then
      playerState = COOP
    else
      playerState = ONDUTY
    end
  end
end

----------------------------------------------------
-- Helper function to create and store a route blip
----------------------------------------------------
function setRouteBlip()
  blips.JobBlip = WideHelper.renderBlip(Config.BlipDetails.JobSite.name, currentJob.AnchorPoint, Config.BlipDetails.JobSite.sprite, Config.BlipDetails.JobSite.color, Config.BlipDetails.JobSite.scale, false)
  SetBlipRoute(blips.JobBlip, true)
end

------------------------------------------
-- Helper function to remove a route blip
------------------------------------------
function removeRouteBlip()
  SetBlipRoute(blips.JobBlip, false)
  RemoveBlip(blips.JobBlip)
end

---------------------------------------
-- Function to clean up entire job.
-- Either deletes the vehicle or sets
-- it as no longer needed. Then clear
-- all blip and task tables.
-- If co-op player exists, clear Id
-- references then if player is parent
-- force the child to stop job and clean up
-- if player is child, clean up self, and
-- clear parent ChildId
---------------------------------------
function janitor(player, shouldDeleteVehicle)
  local vehicle = GetVehiclePedIsIn(player, false)

  if parentId then
    TriggerServerEvent('lsdwp:triggerClearChildId', parentId)
    parentId = nil
  elseif childId then
    TriggerServerEvent('lsdwp:triggerForceCleanup', childId)
    childId = nil
  end
  
  if shouldDeleteVehicle then
    WideHelper.DeleteVehicle(vehicle)
  else
    SetEntityAsNoLongerNeeded(vehicle)
  end

  jobVehicle = nil

  if blips.JobBlip then
    SetBlipRoute(blips.JobBlip, false)
    RemoveBlip(blips.JobBlip)
  end

  for i=1, #blips do
    if blips[i].blipId then
      RemoveBlip(blips[i].blipId)
    end
  end

  for j=1, #onsiteTasks do
    onsiteTasks[j] = nil
  end
end

----------
-- THREADS
----------
-------------------------------------------------
-- Thread for handling playerState
-- Depending on state, call appropriate function
-- Each function called is responsible for
-- sleeping thread at appropriate times.
-------------------------------------------------
Citizen.CreateThread(function() 
  while Unity == nil do
    TriggerEvent('unity:import', function(obj) Unity = obj end, {'Utils'})
    Citizen.Wait(0)
  end

  WideHelper.renderBlip(Config.BlipDetails.DutyStart.name, Config.DutyStartLocation, Config.BlipDetails.DutyStart.sprite, Config.BlipDetails.DutyStart.color, Config.BlipDetails.DutyStart.scale, true)

  while true do
    Citizen.Wait(0)

    if playerState == OFFDUTY then
      offDuty()
    elseif playerState == ONDUTY then
      onDuty()
    elseif playerState == ENROUTE then
      enRoute()
    elseif playerState == ONSITE then
      onSite()
    end
  end
end)

-----------------------------------------------
-- Thread for handling vehicle
-- return or quitting job. Distance
-- check to conditionally draw marker
-- based on if you're in a vehicle or not.
-- Distance check for input key usage then
-- if input key pressed, check if player is
-- in driver's seat and if the vehicle is the
-- job vehicle assigned. If so, clean up job
-- and return security deposit. If on foot, 
-- no security deposit return and clean up job
-----------------------------------------------
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)

    if playerState ~= OFFDUTY then
      local player                         = PlayerPedId()
      local playerCoords                   = GetEntityCoords(player)
      local playerDistanceFromVehicleSpawn = GetDistanceBetweenCoords(playerCoords, Config.VehicleSpawnLocation, false)
      local isPedInVehicle                 = IsPedInAnyVehicle(player, false)
    
      if playerDistanceFromVehicleSpawn < Config.VehicleSpawnMarkerDrawDistance then
        if isPedInVehicle then
          if not parentId then
            WideHelper.Draw3DText(Config.VehicleSpawnLocation, Config.InputKeyLabel..' Return Vehicle')
          end
        else
          WideHelper.Draw3DText(Config.VehicleSpawnLocation, Config.InputKeyLabel..' To Stop')
        end
    
        if playerDistanceFromVehicleSpawn < Config.VehicleSpawnInputKeyUseDistance then
          if IsControlJustReleased(0, Config.InputKey) then
            if parentId and isPedInVehicle then
              goto continue
            elseif parentId and not isPedInVehicle then
              playerState = OFFDUTY
              exports['mythic_notify']:DoHudText('inform', 'You\'re No Longer Accepting Jobs')
              janitor(player, false)
              goto continue
            end

            if isPedInVehicle then
              local vehicle = GetVehiclePedIsIn(player, false)

              if GetPedInVehicleSeat(vehicle, -1) ~= player then
                exports['mythic_notify']:DoHudText('error', "You're Not In The Driver's Seat")
              else
                if GetEntityModel(vehicle) ~= Config.VehicleHash then
                  exports['mythic_notify']:DoHudText('error', 'This Is Not Your Job Vehicle')
                else
                  FreezeEntityPosition(vehicle, true)
                  FreezeEntityPosition(player, true)
                  TriggerServerEvent('lsdwp:returnVehicle')
                  FreezeEntityPosition(player, false)
                end
              end
            else
              playerState = OFFDUTY
              exports['mythic_notify']:DoHudText('inform', 'You\'re No Longer Accepting Jobs')
              -- exports['mythic_notify']:DoHudText('inform', 'You Did Not Receive Your Security Deposit')
              janitor(player, false)
            end
            ::continue::
          end
        end
      else
        Citizen.Wait(1000)
      end
    else
      Citizen.Wait(1000)
    end
  end
end)

-------------------------------------------
-- Thread for checking if TaskShowKey
-- is pressed while playerState is ONSITE.
-- If so, show all current task markers
-------------------------------------------
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)

    if playerState == ONSITE then
      if IsControlPressed(0, Config.TaskShowKey) then
        for n=1, #onsiteTasks do
          local taskX, taskY, taskZ = table.unpack(onsiteTasks[n])
          taskZ = taskZ + 1.11
          WideHelper.Draw3DText(vector3(taskX, taskY, taskZ), Config.InputKeyLabel..' To Repair')
        end
      end
    else
      Citizen.Wait(1000)
    end
  end
end)

----------
-- EVENTS
----------
-----------------------
-- Job starting event
-- Spawn vehicle, then
-- change playerState
-----------------------
RegisterNetEvent('lsdwp:startJob')
AddEventHandler('lsdwp:startJob', function()
  jobVehicle  = WideHelper.renderVehicle(Config.VehicleName, Config.VehicleSpawnLocation)
  -- exports['mythic_notify']:DoHudText('inform', 'You Paid $'..Config.VehicleRentalPrice..' As A Deposit')
  playerState = ONDUTY
  spawnVehicleKeyPressed = false
end)

----------------------
-- Job ending event
-- change playerState 
-- then clean up job
----------------------
RegisterNetEvent('lsdwp:endJob')
AddEventHandler('lsdwp:endJob', function()
  playerState = OFFDUTY
  janitor(PlayerPedId(), true)
  exports['mythic_notify']:DoHudText('inform', 'You\'re No Longer Accepting Jobs')
  -- exports['mythic_notify']:DoHudText('inform', 'Security Deposit Returned')
end)

--------------------------------------------------
-- Event is triggered when the client is invited
-- to join co-op mode. Check if player is on duty
-- if not, show notification and wait 5 seconds
-- for client to accept invitation.
-- If accepted, tell inviter and set parentId
--------------------------------------------------
RegisterNetEvent('lsdwp:playerInvited')
AddEventHandler('lsdwp:playerInvited', function(inviterId, playerId)
  if playerState ~= OFFDUTY then
    TriggerServerEvent('lsdwp:triggerPlayerIsBusy', inviterId)
    return
  end

  local breakLoop = false

  exports['mythic_notify']:DoLongHudText('inform', "Press "..Config.InputKeyLabel.." To Accept Job Invite")

  Citizen.SetTimeout(5000, function()
    breakLoop = true
  end)

  while true do
    Citizen.Wait(0)

    if breakLoop then
      break
    end

    if IsControlJustReleased(0, Config.InputKey) then
      exports['mythic_notify']:DoLongHudText('inform', "You Accepted The Invitation")
      TriggerServerEvent('lsdwp:inviteAccepted', inviterId, playerId)
      parentId = inviterId
      break
    end
  end
end)

-------------------------------------------
-- Event is triggered when target player 
-- accepts invitiation to join co-op mode
-- Show notification, set ChildId and then
-- based on client state, update co-op
-- player with information
-------------------------------------------
RegisterNetEvent('lsdwp:targetPlayerAcceptedInvite')
AddEventHandler('lsdwp:targetPlayerAcceptedInvite', function(playerId)
  exports['mythic_notify']:DoLongHudText('inform', "Your Invitation Was Accepted")
  childId = playerId

  if playerState == ENROUTE then
    TriggerServerEvent('lsdwp:sendJobInfo', currentJob, childId)
  elseif playerState == ONSITE then
    TriggerServerEvent('lsdwp:updateTasks', onsiteTasks, childId, currentJob)
  end
end)

------------------------------------------
-- Event is triggered after client
-- accepted invitiation and inviter 
-- was ENROUTE or when parent selects
-- a new job. Set currentJob then
-- set route blip and change client state
------------------------------------------
RegisterNetEvent('lsdwp:receiveJobInfo')
AddEventHandler('lsdwp:receiveJobInfo', function(tempJob)
  currentJob = tempJob
  setRouteBlip()
  playerState = COOP
end)

-------------------------------------
-- Event is triggered after client
-- accepted invitiation and inviter 
-- was ONSITE or when parent selects
-- new tasks. Set tasklist, render
-- blips and change client state
-------------------------------------
RegisterNetEvent('lsdwp:receiveTasks')
AddEventHandler('lsdwp:receiveTasks', function(tempTasks, job)
  onsiteTasks = tempTasks
  currentJob = job

  for i=1, #onsiteTasks do
    local blip = WideHelper.renderBlip(Config.BlipDetails.Task.name, onsiteTasks[i], Config.BlipDetails.Task.sprite, Config.BlipDetails.Task.color, Config.BlipDetails.Task.scale, true)
    table.insert(blips, {blipId = blip, blipLocation = onsiteTasks[i]})
  end

  for j=1, #onsiteTasks do
    if j ~= 1 then
      if tostring(onsiteTasks[j-1]) == tostring(onsiteTasks[j]) then
        print('duplicate task exists')
      end
    end
  end

  playerState = ONSITE
end)

------------------------------------
-- Event is triggered when parent
-- is ENROUTE and gets close enough
-- to the AnchorPoint
------------------------------------
RegisterNetEvent('lsdwp:removeChildJobBlip')
AddEventHandler('lsdwp:removeChildJobBlip', function()
  removeRouteBlip()
end)

------------------------------------
-- Event is triggered if co-op when
-- either player completes a task. 
-- Determine which task blip should
-- be removed, then remove it
------------------------------------
RegisterNetEvent('lsdwp:removeTaskBlip')
AddEventHandler('lsdwp:removeTaskBlip', function(blipLocation)
  for i=1, #blips do
    if blips[i].blipLocation then
      if tostring(blipLocation) == tostring(blips[i].blipLocation) then
        RemoveBlip(blips[i].blipId)
      end
    end
  end
end)

------------------------------------
-- Event is triggered if co-op when
-- either player completes a task. 
-- Determine which task should
-- be removed, then remove it
------------------------------------
RegisterNetEvent('lsdwp:removeTask')
AddEventHandler('lsdwp:removeTask', function(task)
  while true do
    Citizen.Wait(0)

    if not canQueryTasks then
      Citizen.Wait(500)
    end

    canQueryTasks = false

    for i=1, #onsiteTasks do
      if task == tostring(onsiteTasks[i]) then
        table.remove(onsiteTasks, i)
      end
    end

    canQueryTasks = true
    break
  end
end)

------------------------------------
-- Event triggered during clean up,
-- clears parents ChildId
------------------------------------
RegisterNetEvent('lsdwp:clearChildId')
AddEventHandler('lsdwp:clearChildId', function()
  childId = nil
end)

------------------------------------
-- Event triggered during clean up,
-- forces child to go offduty and 
-- cleans up the job
------------------------------------
RegisterNetEvent('lsdwp:forceCleanup')
AddEventHandler('lsdwp:forceCleanup', function()
  parentId = nil
  playerState = OFFDUTY
  janitor(PlayerPedId(), false)
end)

------------------------------------------
-- Event triggered when co-op and
-- a player triggers a repair. This
-- event is used to prevent douchebaggery
------------------------------------------
RegisterNetEvent('lsdwp:setTaskInProgress')
AddEventHandler('lsdwp:setTaskInProgress', function(entityCoords)
  taskInProgress = entityCoords
end)

-------------------------------------
-- Event triggered during invite
-- if the target player is anything
-- but OFFDUTY, error
-------------------------------------
RegisterNetEvent('lsdwp:playerIsBusy')
AddEventHandler('lsdwp:playerIsBusy', function()
  exports['mythic_notify']:DoHudText('error', "Person Invited Is Busy")
end)

------------------------------------------------
-- Event triggered when someone tries to 
-- start the job, but doesn't have enough money
------------------------------------------------
RegisterNetEvent('lsdwp:clearSpawnVehicleKey')
AddEventHandler('lsdwp:clearSpawnVehicleKey', function()
  spawnVehicleKeyPressed = false
end)
------------
-- COMMANDS
------------
---------------------------------------------------
-- Command to invite target player to co-op mode
-- /invite <playerID>
-- If player is OFFDUTY or currently in co-op mode
-- error, check for valid ID format and if 
-- target player is online.
---------------------------------------------------
RegisterCommand('invite', function(source, args)
  if parentId or playerState == OFFDUTY then
    exports['mythic_notify']:DoHudText('error', "You Must Be On Duty Alone To Invite")
    return
  end

  if childId then
    exports['mythic_notify']:DoHudText('error', "You Already Have Someone Working With You")
    return
  end

  local tempId = tonumber(args[1])

  if tempId == nil then
    exports['mythic_notify']:DoHudText('error', "Invalid Text Input")
    return
  end
  
  if not NetworkIsPlayerActive(GetPlayerFromServerId(tempId)) then
    exports['mythic_notify']:DoHudText('error', "Person Invited Is Not Available")
    return
  end
  
  TriggerServerEvent('lsdwp:invitePlayer', tempId)
end)

-- -----------------------------------------
-- -- TEMPORARY HELPER DURING DEVELOPMENT
-- -----------------------------------------
-- Citizen.CreateThread(function()
--   while true do
--     Citizen.Wait(0)

--     if IsControlJustReleased(0, 82) then
--       local entityHash, entityCoords = WideHelper.saveObject(3.0)

--       if entityHash and entityCoords then
--         TriggerServerEvent('lsdwp:saveObject', {entityHash = entityHash, entityCoords = entityCoords})
--       else
--         TriggerEvent('chat:addMessage', {
--           color = {255, 0, 0},
--           args = { "Server", "Unable to save object information!"}
--         })
--       end
--     end
--   end
-- end)