local funcs = require("engine/core/funcs")
local player = require("engine/modules/player/player")
local data = require("engine/core/data")
local players = require("engine/modules/multiplayer/players")
local server_config = require("server_config")

local commands = {}

commands.list = {"help", "rndshader", "players", "spawn", "debug"}

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
    for nickname, player_data in pairs(players.pseudo) do
        funcs.create_message(player, nil, nickname, os.clock(), 152, 255, 92)
    end
end

function commands.spawn()
    funcs.create_message(player, nil, "Вы были телепортированы на спавн сервера", os.clock(), 152, 255, 92)
    player.x = server_config.spawn_x
    player.y = server_config.spawn_y
end

function commands.debug()
    if data.display_debug == true then
        data.display_debug = false
    else
        data.display_debug = true
    end
end


return commands