CreateThread = Citizen.CreateThread
Wait = Citizen.Wait
Players = {}

CreateThread(function()
    print("^8===================================")
    print("^5Wheater Script By TheFRcRaZy")
    print("^8===================================")
    print("^5TWITCH >> https://twitch.tv/thefrcrazy")
    print("^8===================================^7")
end)

AddEventHandler('playerConnecting', function(name , reject, deferrals)
    local playerId, identifier = source
    for k,v in ipairs(GetPlayerIdentifiers(playerId)) do
		if string.match(v, 'license:') then
			identifier = string.sub(v, 9)
            Players[playerId] = {
                id = playerId,
                identifier = identifier,
                name = GetPlayerName(playerId)
            }
			break
		end
	end
end)

RegisterNetEvent("crz_weather:setPlyOnList")
AddEventHandler("crz_weather:setPlyOnList", function()
    local playerId, identifier = source
    for k,v in ipairs(GetPlayerIdentifiers(playerId)) do
		if string.match(v, 'license:') then
			identifier = string.sub(v, 9)
            Players[source] = {
                id = source,
                identifier = identifier,
                name = GetPlayerName(source)
            }
			break
		end
	end
end)

RegisterNetEvent("crz_weather:getHasPermission")
AddEventHandler("crz_weather:getHasPermission", function()
    for k,v in pairs(Config.permissions) do
        if v == Players[source].identifier then
            TriggerClientEvent("crz_weather:initCommands", source)
            break
        end
    end
end)

RegisterNetEvent("crz_weather:useCommand")
AddEventHandler("crz_weather:useCommand", function(cmd, arg, arg2)
    if arg == "true" then
        arg = true
    elseif arg == "false" then
        arg = false
    end
    if cmd == "setWeather" then
        if not Config.weather[arg] then
            return TriggerClientEvent("crz_weather:errorNotify", source, Config.text[Config.lang]["error_weather"])
        end
        current["weather"] = arg
        TriggerClientEvent("crz_weather:syncWeather", -1, current["weather"], current["blackout"])

    elseif cmd == "setNextWeather" then
        if not Config.weather[arg] then
            return TriggerClientEvent("crz_weather:errorNotify", source, Config.text[Config.lang]["error_weather"])
        end
        nextWeather[1] = arg
        nextWeather[2] = Config.weather[math.random(#Config.weather)]
        nextWeather[3] = Config.weather[math.random(#Config.weather)]
        if not Config.isWinter then
            while Config.notWinterBlacklist[nextWeather[2]] do
                nextWeather[2] = Config.weather[math.random(#Config.weather)]
                Wait(0)
            end
            while Config.notWinterBlacklist[nextWeather[3]] do
                nextWeather[3] = Config.weather[math.random(#Config.weather)]
                Wait(0)
            end
        end
        TriggerClientEvent("crz_weather:syncNextWeather", -1, nextWeather)

    elseif cmd == "setTime" then
        if arg == nil or arg2 == nil then
            return TriggerClientEvent("crz_weather:errorNotify", source, Config.text[Config.lang]["error_time"])
        end
        setToHours(arg)
        setToMinute(arg2)
    elseif cmd == "freezeWeather" then
        if arg == nil then
            return TriggerClientEvent("crz_weather:errorNotify", source, Config.text[Config.lang]["error_bool"])
        end
        current["freezeWeather"] = arg

    elseif cmd == "freezeTime" then
        if arg == nil then
            return TriggerClientEvent("crz_weather:errorNotify", source, Config.text[Config.lang]["error_bool"])
        end
        current["freezeTime"] = arg
    elseif cmd == "setBlackout" then
        if arg == nil then
            return TriggerClientEvent("crz_weather:errorNotify", source, Config.text[Config.lang]["error_bool"])
        end
        current["blackout"] = arg
        TriggerClientEvent("crz_weather:syncWeather", -1, current["weather"], current["blackout"])
    end
end)