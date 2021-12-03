VorpInv = exports.vorp_inventory:vorp_inventoryApi()

local VorpCore = {}
TriggerEvent("getCore",function(core)
    VorpCore = core
end)

RegisterNetEvent('DVR_Xmas:checkIsItem', function()
    local _source = source
    local User = VorpCore.getUser(_source) 
    local gift = 1

    local Character = User.getUsedCharacter
    local identifier = Character.identifier
    local giftPlayer = math.random(1, 5)

	exports.ghmattimysql:execute('SELECT * FROM Gift WHERE identifier=@id', {['@id'] = identifier}, function(gotInfo)
		if gotInfo[1] ~= nil then
		    TriggerClientEvent("DVR_Xmas:sendgift", _source)
		else
            if identifier then 
			    exports.ghmattimysql:execute("INSERT INTO Gift (identifier, gift) VALUES (@Identifier, @gift)", {['@Identifier'] = identifier, ['@gift'] = gift})
                TriggerEvent("vorp:addMoney", _source, 0, giftPlayer)
                TriggerClientEvent("vorp:Tip", _source, Config.Gain.. ' ' ..giftPlayer.. ' $', 5000)
            end
		end
	end)
end)

RegisterNetEvent('DVR_Xmas:deletealltable', function()
    exports.ghmattimysql:execute("DELETE FROM Gift")
end)