local funcs = require("engine/core/funcs")
local player = require("engine/modules/player/player")
local data = require("engine/core/data")

local commands = {}

commands.list = {"help", "rndshader"}

function commands.help()
    funcs.create_message(player, nil, "Список команд:", os.clock(), 152, 255, 92)
    for _, command in pairs(commands.list) do
        funcs.create_message(player, nil, "/" .. command, os.clock(), 152, 255, 92)
    end
end

function commands.rndshader()
    data.settings.shaders = love.math.random(#data.settings_values.shaders)
end


return commands