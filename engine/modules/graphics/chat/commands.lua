local funcs = require("engine/core/funcs")
local player = require("engine/modules/player/player")

local commands = {}

commands.list = {"help"}

function commands.help()
    funcs.create_message(player, "Это вспомогательная команда!", os.clock(), 125, 227, 255)
    funcs.create_message(player, "Она обязательно вам чем то поможет.", os.clock(), 125, 227, 255)
    funcs.create_message(player, "Вот варианты чем:", os.clock(), 125, 227, 255)
    funcs.create_message(player, "1. Вообще ничем", os.clock(), 125, 227, 255)
    funcs.create_message(player, "2. Чем-то (придумайте сами)", os.clock(), 125, 227, 255)
end


return commands