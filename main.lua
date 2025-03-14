local funcs = require("funcs")
local player = require("player")
local map = require("map")
local display = nil
local update = require("update")
local multiplayer = require("multiplayer")
local start = require("start")
local keyboard = require("keyboard")
local json = require("json")

settings = {shader = nil, name = 'mrwek', multiplayer = false}

local message = ""

local fps = 0
fps_display = 0
local fps_timer = os.time()
local update_planet_timer = os.clock()
local earth = map.generation('start')
local update_chat_timer = os.clock()
local server_time_timer = os.clock()
local server_update_timer = os.clock()

function love.load(arg)
    if settings.multiplayer ~= 'server' then
        display = require("display")
        love.window.setMode(1920, 1080)
        love.mouse.setVisible(false)
        love.window.setTitle("P core")
        funcs.blocks_imgs_load()

        if settings.multiplayer == 'client' then
            multiplayer.connect_to_server("147.45.74.217:7777")
        end
    else
        multiplayer.server_start("147.45.74.217:7777")
    end

    if settings.multiplayer == 'server' or settings.multiplayer == false then
        player, earth = start.game(player)
    end

end

function love.textinput(text)
    if settings.multiplayer ~= 'server' and player.chat_status == 'open' then
        message = message .. text
    end
end

function love.update(dt)

    if settings.multiplayer ~= 'server' then

        if os.time() > fps_timer then
            fps_display = fps
            fps = 0
            fps_timer = os.time()
        else
            fps = fps + 1
        end

        player, earth, message = keyboard.update(player, earth, message)

    elseif server_update_timer + 0.25 < os.clock() then
        if server_time_timer + 30 < os.clock() then
            player = funcs.create_message(player, earth.ticks .. ' server ticks', os.clock(), 0, 173, 3)
            print(earth.ticks .. ' server ticks')
            server_time_timer = os.clock()
        end
        multiplayer.server()

        server_update_timer = os.clock()
    end

    if settings.multiplayer == 'client' and update_chat_timer + 1 < os.clock() then
        server_out = multiplayer.client('')
        if server_out ~= nil then
            --player = funcs.create_message(player, server_out, os.clock(), 255, 55, 255)
            player.chat = json.decode(server_out)
            player.chat_size = funcs.array_size(player.chat)
            --player = funcs.create_message(player, , os.clock(), 255, 55, 255)
        end
        update_chat_timer = os.clock()
    end

    if settings.multiplayer ~= 'client' and update_planet_timer + 0.05 < os.clock() then
        earth = update.planet(earth)
        update_planet_timer = os.clock()
    end

end

function love.draw()
    if settings.multiplayer ~= 'server' then
        display.all(settings, earth, message)
    end
end