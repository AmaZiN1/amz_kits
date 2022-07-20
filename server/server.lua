ESX = nil

TriggerEvent('esx:getSharedObject', function(obj)
	ESX = obj
end)

function getKitCooldown(kitname)
	for i=1, #Config.Kits, 1 do
		if Config.Kits[i].name == kitname then
			return Config.Kits[i].duration
		end
	end
end

function firstReedem(ide, kitname)
	local kitCooldown = getKitCooldown(kitname)
	local nextReedem = os.time() + (kitCooldown * 60 * 60)
	MySQL.Async.execute('INSERT INTO amz_kits VALUES(@ide,@kitName,@reedemDate)', {
		['@ide'] = ide,
		['@kitName']  	= kitname,
		['@reedemDate'] = nextReedem
	}, function(rowsChanged)
	end)
end

function reedemKit(ide, kitname)
	local kitCooldown = getKitCooldown(kitname)
	local nextReedem = os.time() + (kitCooldown * 60 * 60)
	MySQL.Async.fetchAll("UPDATE amz_kits SET reedemDate = @reedemDate WHERE identifier = @ide AND kitName = @kitname",
	{
		['@ide'] = ide,
		['@kitname']  	= kitname,
		['@reedemDate'] = nextReedem
	},
	function(result)
	end)
end

function giveItems(src,kitname)
	local xPlayer = ESX.GetPlayerFromId(src)

	for i=1, #Config.Kits, 1 do
		if Config.Kits[i].name == kitname then
			if Config.Kits[i].money > 0 then
				xPlayer.addMoney(Config.Kits[i].money);
			end
			if (Config.Kits[i].weapons == nil) == false then
				for j=1, #Config.Kits[i].weapons, 1 do
					xPlayer.addWeapon(Config.Kits[i].weapons[j].weaponModel, Config.Kits[i].weapons[j].ammo)
				end
			end
			if (Config.Kits[i].items == nil) == false then
				for j=1, #Config.Kits[i].items, 1 do
					xPlayer.addInventoryItem(Config.Kits[i].items[j].itemName, Config.Kits[i].items[j].amount)
				end
			end
		end
	end
end

ESX.RegisterServerCallback('amz_kits:check', function(source, cb, kitname)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local ide = xPlayer.identifier

	MySQL.Async.fetchAll("SELECT reedemDate FROM amz_kits WHERE identifier = @ide AND kitName = @kitname",
	{
		["@ide"] = ide,
		["@kitname"] = kitname
	},
	function(result)
		if result and #result == 0 then
			firstReedem(ide, kitname)
			TriggerClientEvent('esx:showNotification', source, _U('success_reedem'))
			giveItems(_source,kitname)
		elseif tonumber(result[1].reedemDate) < tonumber(os.time()) then
			TriggerClientEvent('esx:showNotification', source, _U('success_reedem'))
			reedemKit(ide, kitname)
			giveItems(_source,kitname)
		else
			local leftHours = ((tonumber(result[1].reedemDate) - tonumber(os.time()))/60)/60
			local msg = _U('need_to_wait') .. math.floor((leftHours * 10))/10 .. _U('hours_symbol')
			TriggerClientEvent('esx:showNotification', source, msg)
		end
	end)
end)