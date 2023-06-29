local QBCore = exports['qb-core']:GetCoreObject()

local playersSuperSpeedEnabled = {}

RegisterServerEvent("toggleSuperSpeed")
AddEventHandler("toggleSuperSpeed", function(enabled)
    local src = source
    playersSuperSpeedEnabled[src] = enabled
    TriggerClientEvent("toggleSuperSpeed", src, enabled)
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        for src, enabled in pairs(playersSuperSpeedEnabled) do
            TriggerClientEvent("toggleSuperSpeed", src, enabled)
        end
    end
end)

QBCore.Functions.CreateUseableItem("flashsuit", function(source)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player.Functions.GetItemByName("flashsuit") then return end
    TriggerClientEvent("qb-smallresources:triggerflash", src)
end)