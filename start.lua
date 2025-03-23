local start = {}
local map = require("level_two/map")
local funcs = require("level_two/funcs")
local player = require("level_three/player")
local data = require("level_three/data")
local planets = require("level_three/planets")
local fonts = require("level_three/fonts")
local json = require("level_three/json")

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
    love.window.setIcon(love.image.newImageData("textures/icon.png"))
    funcs.blocks_imgs_load()

    funcs.update_settings()

    player = funcs.create_message(player, 'Вы оказались на планете Pcore', 3, 125, 227, 255)
    player = funcs.create_message(player, 'Постройте корабль и выбирайтесь отсюда!', 5, 125, 227, 255)

    player.camera.y = 30

    planets[data.planet] = map.generation("debug1")

end

return start