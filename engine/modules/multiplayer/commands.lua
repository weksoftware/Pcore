local funcs = require "engine/core/funcs"

local commands = {}
-- Серверные команды

commands.list = {"say", "save"}

function commands.say(text)
    return text
end

function commands.save(text)
    funcs.save_map(text)
    return "Игра сохранена в файл " .. text
end

return commands