TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local playerNames = {}
local SQLTable = { canQuery = true, queries = {} }
local transactionHistory = {}

-----------------------------------------
-- Function to send a mythic notification
-----------------------------------------
function notify(source, type, text)
    TriggerClientEvent('mythic_notify:client:SendAlert', source, {
        type = type,
        text = text,
    })
end

---------------------------------------
-- Function to format currency strings
---------------------------------------
function comma_value(n) -- credit http://richard.warburton.it
	local left,num,right = string.match(n,'^([^%d]*%d)(%d*)(.-)$')
	return left..(num:reverse():gsub('(%d%d%d)','%1,'):reverse())..right
end

--------------------------------------------------------------------
-- Function to add a query to the SQLTable.queries table once ready
--------------------------------------------------------------------
function submitQuery(query)
    if SQLTable.canQuery then
        table.insert(SQLTable.queries, query)
    else
        Citizen.CreateThread(function()
            while not SQLTable.canQuery do
                Citizen.Wait(100)
            end
            
            table.insert(SQLTable.queries, query)
        end)
    end
end

---------------------------------------------------------------------
-- When player tries to open banking UI, get their name, bank amount, 
-- nearby players names, then send the data off to the client 
---------------------------------------------------------------------
RegisterNetEvent('unity-banking:server:populateBankingData')
AddEventHandler('unity-banking:server:populateBankingData', function(nearbyPlayers, disableDeposit)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local sourceIdentifier = GetPlayerIdentifiers(_source)[1]
    local playerName = playerNames[sourceIdentifier]
    local playerBankAmount = xPlayer.getAccount('bank').money
    local nearbyPlayersNames = {}

    if #nearbyPlayers > 0 then
        for i=1, #nearbyPlayers do
            local playerIdentifier = GetPlayerIdentifiers(nearbyPlayers[i])[1]
            nearbyPlayersNames[tostring(nearbyPlayers[i])] = playerNames[playerIdentifier]
        end
    end

    TriggerClientEvent('unity-banking:client:populateNUIData', _source, playerName, playerBankAmount, nearbyPlayersNames, transactionHistory[sourceIdentifier], disableDeposit)
end)

----------------------------------------------------------
-- Withdraw funds if available, update transactionHistory
-- and send SQL query off for storage, update phone
----------------------------------------------------------
RegisterNetEvent('unity-banking:server:withdrawMoney')
AddEventHandler('unity-banking:server:withdrawMoney', function(amount)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local currentBankBalance = xPlayer.getAccount('bank').money

    if currentBankBalance < amount then
        notify(_source, 'error', 'Not Enough Bank Funds')
        return
    end

    xPlayer.removeAccountMoney('bank', amount)
    xPlayer.addMoney(amount)
    notify(_source, 'success', 'Withdrew $'..amount)
    
    local identifier = GetPlayerIdentifiers(_source)[1]
    local query = { firstname = playerNames[identifier].firstname, lastname = playerNames[identifier].lastname, identifier = identifier, transaction = 'You withdrew $'..comma_value(amount) }
    table.insert(transactionHistory[identifier], 1, { transaction = query.transaction })
    submitQuery(query)

    TriggerClientEvent('unity-banking:client:updateNUIData', _source, xPlayer.getAccount('bank').money, transactionHistory[identifier])
    TriggerClientEvent('unity_phone:updatePersonalInfo', _source)
end)

----------------------------------------------------------
-- Deposit funds if available, update transactionHistory
-- and send SQL query off for storage, update phone
----------------------------------------------------------
RegisterNetEvent('unity-banking:server:depositMoney')
AddEventHandler('unity-banking:server:depositMoney', function(amount)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local currentCashBalance = xPlayer.getMoney()
    local identifier = GetPlayerIdentifiers(_source)[1]

    if amount then
        if currentCashBalance < amount then
            notify(_source, 'error', 'Not Enough Cash')
            return
        end

        xPlayer.removeMoney(amount)
        xPlayer.addAccountMoney('bank', amount)
        notify(_source, 'success', 'Deposited $'..amount)

        local query = { firstname = playerNames[identifier].firstname, lastname = playerNames[identifier].lastname, identifier = identifier, transaction = 'You deposited $'..comma_value(amount) }
        table.insert(transactionHistory[identifier], 1, { transaction = query.transaction })
        submitQuery(query)

        TriggerClientEvent('unity-banking:client:updateNUIData', _source, xPlayer.getAccount('bank').money, transactionHistory[identifier])
        TriggerClientEvent('unity_phone:updatePersonalInfo', _source)
    else
        if currentCashBalance == 0 then
            notify(_source, 'error', 'You Currently Have $0')
            return
        end

        xPlayer.removeMoney(currentCashBalance)
        xPlayer.addAccountMoney('bank', currentCashBalance)
        notify(_source, 'success', 'Deposited $'..currentCashBalance)

        local query = { firstname = playerNames[identifier].firstname, lastname = playerNames[identifier].lastname, identifier = identifier, transaction = 'You deposited $'..comma_value(currentCashBalance) }
        table.insert(transactionHistory[identifier], 1, { transaction = query.transaction })
        submitQuery(query)

        TriggerClientEvent('unity-banking:client:updateNUIData', _source, xPlayer.getAccount('bank').money, transactionHistory[identifier])
        TriggerClientEvent('unity_phone:updatePersonalInfo', _source)
    end
end)

----------------------------------------------------------
-- Transfer funds if available, update transactionHistory
-- and send SQL query off for storage, update phone
----------------------------------------------------------
RegisterNetEvent('unity-banking:server:transferMoney')
AddEventHandler('unity-banking:server:transferMoney', function(playerId, amount)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local otherXPlayer = ESX.GetPlayerFromId(playerId)
    local currentBankBalance = xPlayer.getAccount('bank').money

    if _source == playerId then
        notify(_source, 'error', 'You Can\'t Transfer Money To Yourself')
        return
    end

    if currentBankBalance < amount then
        notify(_source, 'error', 'Not Enough Funds')
        return
    end

    if not otherXPlayer then
        notify(_source, 'error', 'Can\'t Find Target Player')
        return
    end

    xPlayer.removeAccountMoney('bank', amount)
    otherXPlayer.addAccountMoney('bank', amount)

    local initiatorIdentifier = GetPlayerIdentifiers(_source)[1]
    local initiatorFirstName = playerNames[initiatorIdentifier].firstname
    local initiatorLastName = playerNames[initiatorIdentifier].lastname

    local receiverIdentifier = GetPlayerIdentifiers(playerId)[1]
    local receiverFirstName = playerNames[receiverIdentifier].firstname
    local receiverLastName = playerNames[receiverIdentifier].lastname

    notify(_source, 'success', 'Transferred $'..amount..' to '..receiverFirstName..' '..receiverLastName)
    notify(playerId, 'success', 'Received $'..amount..' from '..initiatorFirstName..' '..initiatorLastName)

    local initiatorQuery = { firstname = initiatorFirstName, lastname = initiatorLastName, identifier = initiatorIdentifier, transaction = '$'..comma_value(amount)..' sent to '..receiverFirstName..' '..receiverLastName }
    local receiverQuery = { firstname = receiverFirstName, lastname = receiverLastName, identifier = receiverIdentifier, transaction = '$'..comma_value(amount)..' received from '..initiatorFirstName..' '..initiatorLastName }

    table.insert(transactionHistory[initiatorIdentifier], 1, { transaction = initiatorQuery.transaction })
    table.insert(transactionHistory[receiverIdentifier], 1, { transaction = receiverQuery.transaction })

    submitQuery(initiatorQuery)
    submitQuery(receiverQuery)

    TriggerClientEvent('unity-banking:client:updateNUIData', _source, xPlayer.getAccount('bank').money, transactionHistory[initiatorIdentifier])
    TriggerClientEvent('unity-banking:client:updateNUIData', playerId, otherXPlayer.getAccount('bank').money, transactionHistory[receiverIdentifier])
    TriggerClientEvent('unity_phone:updatePersonalInfo', _source)
    TriggerClientEvent('unity_phone:updatePersonalInfo', playerId)
end)

-----------------------------------------------------------------------------------------------------
-- On spawn get players name and store it in playerNames table, key = players identifier
-- also most recent transaction history, store in transactionHistory table, key = players identifier
-----------------------------------------------------------------------------------------------------
AddEventHandler('eventHandler:server:characterSpawned', function(source)
    local identifier = GetPlayerIdentifiers(source)[1]

    MySQL.ready(function()
        MySQL.Async.fetchAll('SELECT firstname, lastname FROM users where identifier = @identifier', { ['identifier'] = identifier }, function(result)
            if result then
                playerNames[identifier] = result[1]

                MySQL.Async.fetchAll('SELECT transaction FROM banking_transactions where firstname = @firstname AND lastname = @lastname AND steamid = @steamid ORDER BY id DESC LIMIT @limit', { ['firstname'] = result[1].firstname, ['lastname'] = result[1].lastname, ['steamid'] = identifier, ['limit'] = Config.TransactionHistoryLimit }, function(result2)
                    if result2 then
                        transactionHistory[identifier] = result2
                    end
                end)
            end
        end)
    end)
end)

---------------------------------------------------------
-- On player drop clear name from playerNames table
-- and transaction history from transactionHistory table
---------------------------------------------------------
AddEventHandler('playerDropped', function ()
    local _source = source
    local identifier = GetPlayerIdentifiers(_source)[1]
    playerNames[identifier] = nil  
    transactionHistory[identifier] = nil
end)

------------------------------------------------------------------
-- On character delete, delete transaction history from database
-- also set their playerNames and transactionHistory table to nil
------------------------------------------------------------------
AddEventHandler('eventHandler:server:characterDeleted', function(identifier, firstname, lastname)
    MySQL.ready(function()
        MySQL.Async.execute('DELETE FROM banking_transactions WHERE steamid = @steamid AND firstname = @firstname AND lastname = @lastname', { ['steamid'] = identifier, ['firstname'] = firstname, ['lastname'] = lastname }, function() end)
    end)

    playerNames[identifier] = nil
    transactionHistory[identifier] = nil
end)

------------------------------------------------------------
-- Thread to loop over SQLTable table and save transactions
-- to database every Config.SQLSaveWaitTime amount of time
------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        if #SQLTable.queries > 0 then
            for i=1, #SQLTable.queries do
                local firstname = SQLTable.queries[i].firstname
                local lastname = SQLTable.queries[i].lastname
                local identifier = SQLTable.queries[i].identifier
                local transaction = SQLTable.queries[i].transaction

                MySQL.ready(function()
                    MySQL.Async.execute('INSERT INTO banking_transactions (firstname, lastname, steamid, transaction) VALUES (@firstname, @lastname, @steamid, @transaction)', { ['firstname'] = firstname, ['lastname'] = lastname, ['steamid'] = identifier, ['transaction'] = transaction }, function() end)
                end)

                SQLTable.queries[i] = nil
            end
        end

        Citizen.Wait(Config.SQLSaveWaitTime)
    end
end)