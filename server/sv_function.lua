current = {
    ["weather"] = Config.default["weather"],
    ["freezeWeather"] = false,
    ["freezeTime"] = false,
    ["blackout"] = false
}

nextWeather = Config.default["nextWeather"]

local nextWeatherTimer = 10

CreateThread(function()
    TriggerClientEvent("crz_weather:syncWeather", -1, current["weather"], current["blackout"])
    while true do
        nextWeatherTimer = nextWeatherTimer-1
        Wait(60000)
        if nextWeatherTimer == 0 then
            editNextWeather()
            nextWeatherTimer = 10
        elseif nextWeatherTimer == 5 then
            reloadNextWeather()
        end
    end
end)

editNextWeather = function()
    current["weather"] = nextWeather[1]
    nextWeather[1] = nextWeather[2]
    nextWeather[2] = nextWeather[3]
    nextWeather[3] = Config.weather[math.random(#Config.weather)]
    if not Config.isWinter then
        while Config.notWinterBlacklist[nextWeather[3]] do
            nextWeather[3] = Config.weather[math.random(#Config.weather)]
            Wait(0)
        end
    end
    
    if not current["freezeWeather"] then
        TriggerClientEvent("crz_weather:syncWeather", -1, current["weather"], current["blackout"])
    end
    TriggerClientEvent("crz_weather:syncNextWeather", -1, nextWeather)
end

reloadNextWeather = function()
    local rdm = math.random(1, Config.maxRandom)
    if rdm == 1 then
        nextWeather[1] = Config.weather[math.random(#Config.weather)]
        nextWeather[2] = Config.weather[math.random(#Config.weather)]
        nextWeather[3] = Config.weather[math.random(#Config.weather)]
        if not Config.isWinter then
            while Config.notWinterBlacklist[nextWeather[1]] do
                nextWeather[1] = Config.weather[math.random(#Config.weather)]
                Wait(0)
            end
            while Config.notWinterBlacklist[nextWeather[2]] do
                nextWeather[2] = Config.weather[math.random(#Config.weather)]
                Wait(0)
            end
            while Config.notWinterBlacklist[nextWeather[3]] do
                nextWeather[3] = Config.weather[math.random(#Config.weather)]
                Wait(0)
            end
        end
    end
    if not current["freezeWeather"] then
        TriggerClientEvent("crz_weather:syncNextWeather", -1, nextWeather)
    end
end

local baseTime = 0
local timeOffset = 0

CreateThread(function()
	while true do
		Wait(0)
		local newBaseTime = os.time(os.date("!*t"))/2 + 360
		if current["freezeTime"] then
			timeOffset = timeOffset + baseTime - newBaseTime			
		end
		baseTime = newBaseTime
	end
end)

CreateThread(function()
	while true do
		Wait(5000)
        TriggerClientEvent("crz_weather:syncTime", -1, baseTime, timeOffset, current["freezeTime"])
    end
end)

setToHours = function(hours)
    timeOffset = timeOffset - ( ( ((baseTime+timeOffset)/60) % 24 ) - hours ) * 60
end

setToMinute = function(minutes)
    timeOffset = timeOffset - ( ( (baseTime+timeOffset) % 60 ) - minutes )
end