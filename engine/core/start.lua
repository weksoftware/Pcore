local start = {}
local map = require("engine/modules/worlds/update/map")
local funcs = require("engine/core/funcs")
local player = require("engine/modules/player/player")
local data = require("engine/core/data")
local planets = require("engine/modules/worlds/planets")
local fonts = require("engine/modules/graphics/fonts")
local json = require("engine/libs/json")

function start.game()

    love.filesystem.setIdentity("Pcore")
    if love.filesystem.getInfo("settings.json") ~= nil then
        data.settings = json.decode(love.filesystem.read("settings.json"))
    else
        funcs.save_settings()
    end

    if love.filesystem.getInfo("saves") == nil then
        love.filesystem.createDirectory("saves")
    end

    love.window.setMode(800, 600, {vsync=data.settings.vsync, resizable=true})
    fonts.load_fonts()
    love.mouse.setVisible(false)
    love.window.setTitle("Pcore")
    love.window.setIcon(love.image.newImageData("media/textures/icon.png"))
    funcs.blocks_imgs_load()
    funcs.sprites_imgs_load()

    funcs.update_settings()

    player = funcs.create_message(player, 'Вы оказались на планете Pcore', 3, 125, 227, 255)
    player = funcs.create_message(player, 'Постройте корабль и выбирайтесь отсюда!', 5, 125, 227, 255)

    player.camera.y = 30

    planets[data.planet] = map.generation("pcore")

end

return start