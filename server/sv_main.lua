local Props = {}

RegisterServerEvent("redemrp_propplacer:SaveProp")
AddEventHandler("redemrp_propplacer:SaveProp", function(prophash, x ,y, z ,heading)
    local _source = source

    Props[#Props + 1] = {
		prophash = prophash, 
		x = x, 
		y = y, 
		z = z, 
		heading = heading
	}
	
    SaveResourceFile(GetCurrentResourceName(), "Props.json", json.encode(Props), -1)
	
    TriggerClientEvent('redemrp_propplacer:GetProps', _source, Props)
end)

function loadProps()
    local data = LoadResourceFile(GetCurrentResourceName(), "Props.json")	
	
    if not data then
        SaveResourceFile(GetCurrentResourceName(), "Props.json", "[]")
        data = "[]"
    end
	
	Props = json.decode(LoadResourceFile(GetCurrentResourceName(), "Props.json"))
	
    print("^4[redemrp_propplacer] ^2[" .. #Props .. "] Props Loaded ^0")
end


RegisterServerEvent("redemrp_propplacer:PropRequest")
AddEventHandler("redemrp_propplacer:PropRequest", function()
    local _source = source

    TriggerClientEvent('redemrp_propplacer:GetProps', _source, Props)
end)

RegisterServerEvent("redemrp_propplacer:DeleteProp")
AddEventHandler("redemrp_propplacer:DeleteProp", function(id)
    local _source = source

    Props[id] = nil

    SaveResourceFile(GetCurrentResourceName(), "Props.json", json.encode(Props), -1)
    TriggerClientEvent('redemrp_propplacer:GetProps', _source, Props)
end)

loadProps()
