local QBCore = exports['qb-core']:GetCoreObject()

local isSuperSpeedEnabled = false

RegisterNetEvent('qb-smallresources:triggerflash', function(source, args)
    local playerPed = PlayerPedId()
    isSuperSpeedEnabled = not isSuperSpeedEnabled
    
    if isSuperSpeedEnabled then
        QBCore.Functions.Progressbar('Flashon', 'Putting Suit On', 1500, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true
            }, {}, {}, {}, function()
                local player = PlayerId()
        local model = GetHashKey('TheFlash')
    
        RequestModel(model)
        while not HasModelLoaded(model) do
            Wait(100)
        end
    
        SetPlayerModel(player, model)
        SetModelAsNoLongerNeeded(model)
        Notify("Super speed enabled!")
            end, function()
        TriggerServerEvent("toggleSuperSpeed", false)
        ExecuteCommand('refreshskin')
        Notify("Super speed disabled!")
        end)
    else
        QBCore.Functions.Progressbar('Flashoff', 'Taking Suit Off', 1500, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true
            }, {}, {}, {}, function()
                TriggerServerEvent("toggleSuperSpeed", false)
        ExecuteCommand('refreshskin')
        Notify("Super speed disabled!")
            end, function()
                local player = PlayerId()
                local model = GetHashKey('TheFlash')
            
                RequestModel(model)
                while not HasModelLoaded(model) do
                    Wait(100)
                end
            
                SetPlayerModel(player, model)
                SetModelAsNoLongerNeeded(model)
                Notify("Super speed enabled!")
        end)
    end
end)

function Notify(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(false, false)
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerPed = PlayerPedId()
        if isSuperSpeedEnabled then
            SetRunSprintMultiplierForPlayer(playerPed, 1.49)
            SetPedMoveRateOverride(playerPed, 6.0) -- ADJUST THIS IF YOU WANT A FASTER NUMBER
        else
            ResetPlayerStamina(playerPed)
            ResetPedMovementClipset(playerPed, 0.0)
        end
    end
end)