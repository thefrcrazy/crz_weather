Config = {}

Config.lang = "fr"

Config.weather = {
    "EXTRASUNNY", "CLEAR", "SMOG",
    "FOGGY", "OVERCAST", "CLOUDS",
    "NEUTRAL", "CLEARING", "RAIN",
    "THUNDER", "SNOW", "SNOWLIGHT",
    "BLIZZARD", "XMAS", "HALLOWEEN"
}

Config.isWinter = false

Config.notWinterBlacklist = {
    ["SNOW"] = true,
    ["SNOWLIGHT"] = true,
    ["BLIZZARD"] = true,
    ["XMAS"] = true
}

Config.maxRandom = 4


Config.default = {
    ["weather"] = "EXTRASUNNY",
    ["nextWeather"] = {
        [1] = "CLEARING",
        [2] = "RAIN",
        [3] = "CLEAR"
    }
}

Config.text = {
    ["fr"] = {
        ["error_weather"] = "~r~Méteo inconnu",
        ["error_time"] = "~r~Heure/Minute inconnu",
        ["error_bool"] = "~r~Veuillez saisir ~y~true ~r~ou ~y~false",
    },
    ["en"] = {
        ["error_weather"] = "~r~Weather not exist",
        ["error_time"] = "~r~Hours/Minute not exist",
        ["error_bool"] = "~r~Please enter ~y~true ~r~or ~y~false",
    },
}

Config.commands = {
    ["fr"] = {
        ["setWeather"] = {
            desc = "Pour définir une méteo",
            help = {
                {name = "méteo", help = Config.weather}
            },
            type = "string"
        },
        ["setTime"] = {
            desc = "Pour définir l'heure",
            help = {
                {name = "heure", help = "nombre 0-23"},
                {name = "minute", help = "nombre 0-59"}
            },
            type = "number"
        },
        ["freezeWeather"] = {
            desc = "Pour bloquer la méteo",
            help = {
                {name = "bool", help = "true ou false"}
            },
            type = "bool"
        },
        ["freezeTime"] = {
            desc = "Pour bloquer l'heure",
            help = {
                {name = "bool", help = "true ou false"}
            },
            type = "bool"
        },
        ["setBlackout"] = {
            desc = "Pour éteindre les lumières de la ville",
            help = {
                {name = "bool", help = "true ou false"}
            },
            type = "bool"
        },
        ["setNextWeather"] = {
            desc = "Pour définir la prochaine méteo + modifier les futur méteo aléatoirement",
            help = {
                {name = "méteo", help = Config.weather}
            },
            type = "string"
        },
        ["getNextWeather"] = {
            desc = "Pour connaître la prochaine méteo",
            help = nil
        },
    },

    ["en"] = {
        ["setWeather"] = {
            desc = "Define weather",
            help = {
                {name = "weather", help = Config.weather}
            },
            type = "string"
        },
        ["setTime"] = {
            desc = "Define time",
            help = {
                {name = "hours", help = "number 0-23"},
                {name = "minutes", help = "number 0-59"}
            },
            type = "number"
        },
        ["freezeWeather"] = {
            desc = "Freeze weather",
            help = {
                {name = "bool", help = "true or false"}
            },
            type = "bool"
        },
        ["freezeTime"] = {
            desc = "Freeze time",
            help = {
                {name = "bool", help = "true or false"}
            },
            type = "bool"
        },
        ["setBlackout"] = {
            desc = "Blackout city light",
            help = {
                {name = "bool", help = "true or false"}
            },
            type = "bool"
        },
        ["setNextWeather"] = {
            desc = "Define next weather + edit the next weather randomly",
            help = {
                {name = "weather", help = Config.weather}
            },
            type = "string"
        },
        ["getNextWeather"] = {
            desc = "Get next weather",
            help = nil
        },
    }
}

Config.permissions = { -- identifier (rockstar)
    "your_identifier",
    "your_identifier"
}