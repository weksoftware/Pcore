local start = {}
local map = require("map")
local funcs = require("funcs")
local player = require("player")
local data = require("data")
local planets = require("planets")

function start.game()

    love.window.setMode(1920, 1080, {vsync=1})
    love.mouse.setVisible(false)
    love.window.setTitle("P core")
    funcs.blocks_imgs_load()

    player = funcs.create_message(player, 'Вы оказались на планете Pcore', 3, 125, 227, 255)
    player = funcs.create_message(player, 'Постройте корабль и выбирайтесь отсюда!', 5, 125, 227, 255)

    player.camera.y = 30

    planets[data.planet] = map.generation("debug1")

end

return start