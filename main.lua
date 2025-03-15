local funcs = require("funcs")
local player = require("player")
local map = require("map")
local display = require("display")
local update = require("update")
local start = require("start")
local keyboard = require("keyboard")
local json = require("json")
local data = require("data")

settings = {shader = nil, name = 'mrwek', multiplayer = false}

local earth = map.generation('start')
local update_chat_timer = os.clock()

function love.load(arg)

    love.window.setMode(1920, 1080)
    love.mouse.setVisible(false)
    love.window.setTitle("P core")
    funcs.blocks_imgs_load()

    if settings.multiplayer == 'client' then
        multiplayer.connect_to_server("147.45.74.217:7777")
    end

    player, earth = start.game(player)

end

function love.update(dt)
    player, earth, data.message = keyboard.update(player, earth)
    data.player = player
    earth = update.planet(earth)
end

function love.draw()
    display.all(settings, earth)
end