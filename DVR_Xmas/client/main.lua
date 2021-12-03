local function Distance(coords, coords2)
	return #(coords-coords2)
end

local function Gift3DText(x, y, z, text , state)
    local onScreen,_x,_y=GetScreenCoordFromWorldCoord(x, y, z)
    local px,py,pz=table.unpack(GetGameplayCamCoord())
    SetTextScale(0.35, 0.35)
    SetTextFontForCurrentCommand(1)
    SetTextColor(255, 255, 255, 215)
    local str = CreateVarString(10, "LITERAL_STRING", text, Citizen.ResultAsLong())
    SetTextCentre(1)
    DisplayText(str,_x,_y)
end

CreateThread(function()
    giftblips = Citizen.InvokeNative(0x554D9D53F696D002, 1664425300,  Config.FirCoords.x, Config.FirCoords.y, Config.FirCoords.z)
    SetBlipSprite(giftblips, 214435071, 1)
    SetBlipScale(giftblips, 1.8)
    Citizen.InvokeNative(0x9CB1A1623062F402, giftblips, Config.BlipName)

    while true do 
        Wait(1)
        if Distance(GetEntityCoords(PlayerPedId()), Config.FirCoords) <= 4.0 then 
            Gift3DText(Config.FirCoords.x, Config.FirCoords.y, Config.FirCoords.z+0.1, Config.TextFir)
            if Distance(GetEntityCoords(PlayerPedId()), Config.FirCoords) <= 1.0 then 
                if IsControlJustPressed(0, 0x760A9C6F) then
                    TriggerServerEvent('DVR_Xmas:checkIsItem')

                    if Config.RemoveBlip then 
                        RemoveBlip(giftblips)
                    end
                    
                    return
                end
            end
        end
    end
end)

RegisterNetEvent('DVR_Xmas:sendgift', function()
    TriggerEvent("vorp:Tip", Config.IsGift, 5000)
end)

AddEventHandler('onResourceStart', function(resource)
	if resource == GetCurrentResourceName() then     
        TriggerServerEvent('DVR_Xmas:deletealltable')
    end
end)