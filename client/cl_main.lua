CreateThread = Citizen.CreateThread
Wait = Citizen.Wait

CreateThread(function()
    print("^8===================================")
    print("^5Wheater Script By TheFRcRaZy")
    print("^8===================================")
    print("^5TWITCH >> https://twitch.tv/thefrcrazy")
    print("^8===================================^7")
    TriggerServerEvent("crz_weather:setPlyOnList")
    Wait(500)
    TriggerServerEvent("crz_weather:getHasPermission")
end)

local current = {
    ["weather"] = Config.default["weather"],
    ["freezeTime"] = nil,
    ["blackout"] = nil
}
local latestWeather = current["weather"]
local nextWeather = Config.default["nextWeather"]

RegisterNetEvent("crz_weather:initCommands")
AddEventHandler("crz_weather:initCommands", function()
    for k,v in pairs(Config.commands[Config.lang]) do
        TriggerEvent('chat:addSuggestion', '/'..k, v.desc, v.help)
        RegisterCommand(k, function(source, args)
            if v.help ~= nil then
                if v.type == "string" then
                    if args[1] == nil then
                        Notify(Config.text[Config.lang]["error_weather"])
                        return
                    end
                    local arg = string.upper(args[1])
                    TriggerServerEvent("crz_weather:useCommand", k, arg)
                elseif v.type == "number" then
                    if args[1] == nil or args[2] == nil then
                        Notify(Config.text[Config.lang]["error_time"])
                        return
                    end
                    local arg1 = tonumber(args[1])
                    local arg2 = tonumber(args[2])
                    TriggerServerEvent("crz_weather:useCommand", k, arg1, arg2)
                elseif v.type == "bool" then
                    if args[1] == nil then
                        Notify(Config.text[Config.lang]["error_bool"])
                        return
                    end
                    local arg = string.lower(args[1])
                    TriggerServerEvent("crz_weather:useCommand", k, arg)
                end
            else
                getNextWeather()
            end
        end)
    end
end)

RegisterNetEvent("crz_weather:syncNextWeather")
AddEventHandler("crz_weather:syncNextWeather", function(nextWeather2)
    nextWeather = nextWeather2
end)

RegisterNetEvent("crz_weather:syncWeather")
AddEventHandler("crz_weather:syncWeather", function(weather, blackout)
    current["weather"] = weather
    current["blackout"] = blackout
    SetArtificialLightsState(current["blackout"])
    SetArtificialLightsStateAffectsVehicles(not current["blackout"])
end)

CreateThread(function()
    ForceSnowPass(Config.isWinter)
    SetForceVehicleTrails(Config.isWinter)
    SetForcePedFootstepsTracks(Config.isWinter)
    while true do
        if latestWeather ~= current["weather"] then
            latestWeather = current["weather"]
            SetWeatherTypeOverTime(current["weather"], 15.0)
            Wait(15000)
        end
        Wait(100)
        ClearOverrideWeather()
		ClearWeatherTypePersist()
        SetWeatherTypePersist(latestWeather)
		SetWeatherTypeNow(latestWeather)
		SetWeatherTypeNowPersist(latestWeather)

        
    end
end)

local baseTime = 0
local timeOffset = 0
local timer = 0

RegisterNetEvent("crz_weather:syncTime")
AddEventHandler("crz_weather:syncTime", function(base, offset, freeze)
    baseTime = base
    timeOffset = offset
    current["freezeTime"] = freeze
end)

CreateThread(function()
    local hour = 0
    local minute = 0
    while true do
        Wait(1000)
        local newBaseTime = baseTime
        if GetGameTimer() - 500 > timer then
            newBaseTime = newBaseTime+0.25
            timer = GetGameTimer()
        end
        if current["freezeTime"] then
            timeOffset = timeOffset + baseTime - newBaseTime
        end
        baseTime = newBaseTime
		hour = math.floor(((baseTime+timeOffset)/60)%24)
		minute = math.floor((baseTime+timeOffset)%60)
		NetworkOverrideClockTime(hour, minute, 0)
    end
end)

getNextWeather = function()
    local text = "10m = "..nextWeather[1].."\n20m = "..nextWeather[2].."\n30m = "..nextWeather[3]
    Notify(text)
end

RegisterNetEvent("crz_weather:errorNotify")
AddEventHandler("crz_weather:errorNotify", function(text)
    Notify(text)
end)

Notify = function(msg)
    SetNotificationTextEntry('STRING')
    AddTextComponentSubstringPlayerName(msg)
    DrawNotification(false, true)
end