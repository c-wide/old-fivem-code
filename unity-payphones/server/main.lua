----------------
-- ESX NONSENSE
----------------
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-------------
-- FUNCTIONS
-------------
----------------------------------------
-- Function to retreive players
-- current balance. If account provided
-- use account, otherwise, use cash
----------------------------------------
function checkMoney(player, account)
    local xPlayer        = ESX.GetPlayerFromId(player)
    local currentAmount  = nil

    if account then
        currentAmount = xPlayer.getAccount(account).money
    else
        currentAmount = xPlayer.getMoney()
    end

    return currentAmount
end

-----------------------------------
-- Function to remove money from
-- player. If account provided use
-- account, otherwise, use cash
-----------------------------------
function removeMoney(player, amount, account)
    local xPlayer = ESX.GetPlayerFromId(player)

    if account then
        xPlayer.removeAccountMoney(account, amount)
    else
        xPlayer.removeMoney(amount)
    end
end

----------
-- EVENTS
----------
-------------------------------------
-- Event to send anonymous 911 Alert
-------------------------------------
RegisterNetEvent('unity-payphones:send911Alert')
AddEventHandler('unity-payphones:send911Alert', function(message)
    local _source = source

    if Config.PayFor911Calls then
        local currentAmount = checkMoney(_source, Config.AccountName)
    
        if currentAmount >= Config.PayphoneUsePrice then
            removeMoney(_source, Config.PayphoneUsePrice, Config.AccountName)
            TriggerClientEvent('esx_outlawalert:outlawNotify', -1, 'anonymousCaller', message)
            TriggerEvent('unity-payphones:BigBrother', _source, '911 Alert', message, nil)
        else
            local text = 'You Need $'..Config.PayphoneUsePrice..' To Make A Call'
    
            TriggerClientEvent('mythic_notify:client:SendAlert', _source, {
                type = 'error',
                text = text,
            })
        end
    else
        TriggerClientEvent('esx_outlawalert:outlawNotify', -1, 'anonymousCaller', message)
        TriggerEvent('unity-payphones:BigBrother', _source, '911 Alert', message, nil)
    end
end)

----------------------------------------------------------
-- Event to handle logging of information to Big Brother.
----------------------------------------------------------
RegisterNetEvent('unity-payphones:BigBrother')
AddEventHandler('unity-payphones:BigBrother', function(playerSource, type, message, target)
    local _source           = source
    local identifierName    = "steam:"
    local playerUsername    = nil
    local playerDiscordName = nil
    local playerIdentifier  = nil
    local targetUsername    = nil
    local targetDiscordName = nil
    local targetIdentifier  = nil

    if playerSource == 'none' then 
        playerSource = _source 
    end

    local playerTable = {playerSource}

    if target then 
        table.insert(playerTable, target)
    end

    for index=1, #playerTable do
        local username    = GetPlayerName(playerTable[index])
        local identifiers = GetPlayerIdentifiers(playerTable[index])
        local identifier  = nil
        local discordName = 'nil'

        for j=1, #identifiers do
            if identifiers[j]:sub(1, identifierName:len()) == identifierName then
                identifier = identifiers[j]
            end
        end

        if exports.discord_perms then
            local discordCheck = exports.discord_perms:GetDiscordName(playerTable[index])
            
            if discordCheck then
                discordName = discordCheck
            end
        end

        if index == 1 then
            playerUsername    = username
            playerDiscordName = discordName
            playerIdentifier  = identifier
        elseif index == 2 then
            targetUsername    = username
            targetDiscordName = discordName
            targetIdentifier  = identifier
        end
    end

    if type == '911 Alert' then
        TriggerEvent('BigBrother:Payphones', type, message, playerSource, playerUsername, playerIdentifier, playerDiscordName)
    elseif type == 'Anonymous Call Starting' then
        TriggerEvent('BigBrother:Payphones', type, message, playerSource, playerUsername, playerIdentifier, playerDiscordName, target, targetUsername, targetIdentifier, targetDiscordName)
    elseif type == 'Anonymous Call Ending' then
        TriggerEvent('BigBrother:Payphones', type, message, playerSource, playerUsername, playerIdentifier, playerDiscordName, target, targetUsername, targetIdentifier, targetDiscordName)
    end
end)

--------------------------------------------------------
-- Event to verify information about phone number
-- Check to make sure a player is not calling themselves
--------------------------------------------------------
RegisterNetEvent('unity-payphones:checkPhoneNumber')
AddEventHandler('unity-payphones:checkPhoneNumber', function(phoneNumber)
    local _source       = source
    local xPlayer       = ESX.GetPlayerFromId(_source)
    local currentAmount = checkMoney(_source, Config.AccountName)
    
    if currentAmount >= Config.PayphoneUsePrice then 
        if xPlayer.get('phoneNumber') == phoneNumber then
            TriggerClientEvent('mythic_notify:client:SendAlert', source, {
                type = 'error',
                text = "You Can't Call Yourself",
            })
            return
        end

        removeMoney(_source, Config.PayphoneUsePrice, Config.AccountName)
        TriggerClientEvent('unity-payphones:startAnonymousCall', source, phoneNumber)
    else
        local text = 'You Need $'..Config.PayphoneUsePrice..' To Make A Call'
    
        TriggerClientEvent('mythic_notify:client:SendAlert', _source, {
            type = 'error',
            text = text,
        })
    end
end)
-------------
-- CALLBACKS
-------------
---------------------------------
-- Callback to check if a player
-- is currently on the phone
---------------------------------
ESX.RegisterServerCallback('unity-payphones:checkCallStatus', function(source, cb)
	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer and xPlayer.get('onCall') then
		cb(true, xPlayer.get('onCall').target)
    else
		cb(false)
    end
end)