local start = {}
local map = require("map")
local funcs = require("funcs")

function start.game(player)
    player = funcs.create_message(player, 'Вы оказались на планете Pcore', 3, 125, 227, 255)
    player = funcs.create_message(player, 'Постарайтесь выбраться отсюда...', 5, 125, 227, 255)

    player.camera.y = 30

    local planet = map.generation("debug1")

    return player, planet
end

return start