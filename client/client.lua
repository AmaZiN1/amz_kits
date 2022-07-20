ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

function EnableGui(enable)
    SetNuiFocus(enable,enable)
    SendNUIMessage({
        type = "enableui",
        enable = enable,
        kits = Config.Kits,
        serverName = Config.ServerName,
        locales = {
            reedemKitLocale = _U('reedem_kit'),
            emptyLocale = _U('empty')
        }
    })
end

RegisterCommand(Config.Command, function(source, args, user)
    EnableGui(true)
end, false)

RegisterNUICallback('closeNUI', function(data, cb)
    EnableGui(false)
    cb('ok')
end)

RegisterNUICallback('reedemKit', function(data, cb)
    -- sprawdz czy dostepny jezeli tak daj itemy
    print(data.kitNameDB)
    ESX.TriggerServerCallback('amz_kits:check', function()
        
    end,data.kitNameDB)
    cb('ok')
end)