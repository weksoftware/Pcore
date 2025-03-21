local start = {}
local map = require("level_two/map")
local funcs = require("level_two/funcs")
local player = require("level_three/player")
local data = require("level_three/data")
local planets = require("level_three/planets")

function start.game()

    love.window.setMode(800, 600, {vsync=0, resizable=true})
    love.mouse.setVisible(false)
    love.window.setTitle("P core")
    love.window.setIcon(love.image.newImageData("textures/icon.png"))
    funcs.blocks_imgs_load()

    player = funcs.create_message(player, 'Вы оказались на планете Pcore', 3, 125, 227, 255)
    player = funcs.create_message(player, 'Постройте корабль и выбирайтесь отсюда!', 5, 125, 227, 255)

    player.camera.y = 30

    planets[data.planet] = map.generation("debug1")

end

return start