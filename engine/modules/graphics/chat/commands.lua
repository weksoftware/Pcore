local funcs = require("engine/core/funcs")
local player = require("engine/modules/player/player")
local data = require("engine/core/data")
local players = require("engine/modules/multiplayer/players")

local commands = {}

commands.list = {"help", "rndshader", "playerss"}

function commands.help()
    funcs.create_message(player, nil, "Список команд:", os.clock(), 152, 255, 92)
    for _, command in pairs(commands.list) do
        funcs.create_message(player, nil, "/" .. command, os.clock(), 152, 255, 92)
    end
end

function commands.rndshader()
    data.settings.shaders = love.math.random(#data.settings_values.shaders)
end

function commands.players()
    funcs.create_message(player, nil, "Список текущих игроков:", os.clock(), 152, 255, 92)

    funcs.create_message(player, nil, data.settings.nickname, os.clock(), 152, 255, 92)
    for _, player_data in pairs(players) do
        funcs.create_message(player, nil, player_data.nickname, os.clock(), 152, 255, 92)
    end
end


return commands