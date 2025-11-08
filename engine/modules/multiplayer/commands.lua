local funcs = require "engine/core/funcs"
local data = require("engine/core/data")

local commands = {}
-- Серверные команды

commands.list = {"say", "save", "tps"}

function commands.say(text)
    return text
end

function commands.save(text)
    funcs.save_map(text)
    return "Игра сохранена в файл " .. text
end

function commands.tps(text)
    return "TPS: " .. tostring(data.tps_display)
end

return commands