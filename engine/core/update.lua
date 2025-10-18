local funcs = require("engine/core/funcs")
local blocks = require("engine/modules/worlds/blocks")
local data = require("engine/core/data")
local player = require("engine/modules/player/player")
local planets = require("engine/modules/worlds/planets")
local keyboard = require("engine/modules/controls/keyboard")
local light = require("engine/modules/worlds/update/light")
local physics = require("engine/modules/worlds/update/physics")
local fonts = require("engine/modules/graphics/fonts")
if data.multiplayer.enet_type ~= "host" then
    gui = require("engine/modules/graphics/gui/gui")
end
local items = require("engine/modules/items/items")
local items_funcs = require("engine/modules/items/items_funcs")
local collision = require("engine/modules/player/collision")

local update_planet_timer = love.timer.getTime()
local update_player_moving_timer = love.timer.getTime()
local autosave_timer = love.timer.getTime()
local players = require("engine/modules/multiplayer/players")

local update = {}

function love.resize(w, h)
    fonts.load_fonts()
end

function love.mousepressed(x, y, button, istouch, presses)
    data.mouse.x = x
    data.mouse.y = y
    data.mouse.button = button
end

function love.mousereleased(x, y, button, istouch, presses)
    data.mouse.button = nil
end

function update.mouse()
    local x, y = love.mouse.getPosition( )
    data.mouse.x = x
    data.mouse.y = y
end

function update.multiblock(block, x, y, planet_w, planet_h)
    local exists = true
    local w = blocks[block].multiblock.w
    local h = blocks[block].multiblock.h
    for xi = 0, w - 1 do
        for yi = 0, h - 1 do
            if block ~= planets[data.planet].map[x + xi][y + yi].block then
                exists = false
            end
            if yi == h - 1 and planets[data.planet].map[x + xi][funcs.coordy(y + yi + 1, planet_h, planet_w)].block == 'air' then
                exists = false
            end
        end
    end
    if exists == false then
        for xi = 0, w - 1 do
            for yi = 0, h - 1 do
                planets[data.planet].map[x + xi][y + yi].block = 'air'
            end
        end
    end
end

function update.blocks(planet, world)
    local planet_name = planet
    local planet = world[planet]
    local h = planet.h
    local w = planet.w
    local subtick_h = h / 10 --Высота, которую игра будет обрабатывать за один сабтик
    local start_h = h - subtick_h * planet.subtick --Высота, с которой начинается обновление

    for x = 1, w do
        for y = start_h, start_h - subtick_h + 1, -1 do
            if blocks[world[planet_name].map[x][y].block].multiblock == nil then
                world[planet_name].map[x][y].img_num = funcs.select_block_img(world[planet_name].map, x, y, world[planet_name].h, world[planet_name].w)
            else
                local multiblock = world[planet_name].map[x][y].multiblock
                world[planet_name].map[x][y].img_num = multiblock.y_in_block * 8 + multiblock.x_in_block + 1
                local block = world[planet_name].map[x][y].block
                if multiblock.x_in_block == 0 and multiblock.y_in_block == 0 then
                    update.multiblock(world[planet_name].map[x][y].block, x, y, w, h)
                elseif world[planet_name].map[multiblock.x][multiblock.y].block ~= world[planet_name].map[x][y].block then
                    for xi = 0, blocks[block].multiblock.w - 1 do
                        for yi = 0, blocks[block].multiblock.h - 1 do
                            world[planet_name].map[multiblock.x + xi][multiblock.y + yi].block = 'air'
                        end
                    end
                end
            end
            if world[planet_name].map[x][y].fire ~= nil then
                if love.math.random() >= 0.4 then
                    local orientation = love.math.random(4)
                    if orientation == 1 and blocks[world[planet_name].map[funcs.coordx(x - 1, h, w)][y].block].flammability ~= nil then
                        world[planet_name].map[funcs.coordx(x - 1, h, w)][y].fire = true
                    elseif orientation == 2 and blocks[world[planet_name].map[x][funcs.coordy(y + 1, h, w)].block].flammability ~= nil then
                        world[planet_name].map[x][funcs.coordy(y + 1, h, w)].fire = true
                    elseif orientation == 3 and blocks[world[planet_name].map[funcs.coordx(x + 1, h, w)][y].block].flammability ~= nil then
                        world[planet_name].map[funcs.coordx(x + 1, h, w)][y].fire = true
                    elseif orientation == 4 and blocks[world[planet_name].map[x][funcs.coordy(y - 1, h, w)].block].flammability ~= nil then
                        world[planet_name].map[x][funcs.coordy(y - 1, h, w)].fire = true
                    end
                end
                if love.math.random() >= blocks[world[planet_name].map[x][y].block].flammability then
                    world[planet_name].map[x][y].fire = nil
                    if blocks[world[planet_name].map[x][y].block].combustion_product ~= nil then
                        world[planet_name].map[x][y].block = blocks[world[planet_name].map[x][y].block].combustion_product
                    else
                        world[planet_name].map[x][y].block = 'air'
                    end
                    world[planet_name].map[x][y].destruction = 0
                end
            end
        end
    end

    return world
end
      
function update.planet(planet, world)
    if update_planet_timer + 0.02 < love.timer.getTime() then
        update_planet_timer = love.timer.getTime()
        if data.multiplayer.enet_type ~= "client" then
            world = physics.update(planet, world)
            world = update.blocks(planet, world)
        end

        world[planet].subtick = world[planet].subtick + 1

        if world[planet].subtick == 10 then
            if data.multiplayer.enet_type ~= "host" then
                light.update()
            end
            world[planet].subtick = 0
            world[planet].ticks = world[planet].ticks + 1
        end
    end
    return world
end

function update.player()
    local width, height = love.graphics.getDimensions()
    player.camera.x = (player.x - width / 2) / player.camera.zoom
    player.camera.y = (player.y - height / 2) / player.camera.zoom

    if planets[data.planet].game_mode == "debug" then
        if player.moving ~= nil and update_player_moving_timer + 0.01 < love.timer.getTime() then
            if player.moving.right == true then
                player.x = player.x + 10
            end
            if player.moving.left == true then
                player.x = player.x - 10
            end
            if player.moving.up == true then
                player.y = player.y - 10
            end
            if player.moving.down == true then
                player.y = player.y + 10
            end
            update_player_moving_timer = love.timer.getTime()
        end
    else
        if update_player_moving_timer + 0.01 < love.timer.getTime() then
            if player.moving.right == true then
                player.x = player.x + 10
            end
            if player.moving.left == true then
                player.x = player.x - 10
            end
            if player.moving.up == true then
                player.y = player.y - 10
            end
            if player.moving.down == true then
                player.y = player.y + 10
            end

            if data.multiplayer.enet_type == "client" then
                for nickname, player_net in pairs(players) do
                    if player_net.moving.right == true then
                        player_net.x = player_net.x + 10
                    end
                    if player_net.moving.left == true then
                        player_net.x = player_net.x - 10
                    end
                    if player_net.moving.up == true then
                        player_net.y = player_net.y - 10
                    end
                    if player.moving.down == true then
                        player_net.y = player_net.y + 10
                    end
                end
            end
            
            -- if collision.player(player.x, player.y + 15, planets[data.planet].map, player.camera.zoom) == false then
            --     player.y = player.y + 15
            -- elseif collision.player(player.x, player.y + 5, planets[data.planet].map, player.camera.zoom) == false then
            --     player.y = player.y + 5
            -- elseif collision.player(player.x, player.y + 1, planets[data.planet].map, player.camera.zoom) == false then
            --     player.y = player.y + 1
            -- end
            update_player_moving_timer = love.timer.getTime()
        end
    end
    if data.scene == 'game' and player.inventory[player.inventory_select] ~= nil then
        if items[player.inventory[player.inventory_select].name].func ~= nil then
            player.inventory[player.inventory_select] = items_funcs[items[player.inventory[player.inventory_select].name].func](player.inventory[player.inventory_select])
        end
    end
end

function update.autosave()
    local autosave_settings = data.settings_values.autosave[data.settings.autosave]
    if data.scene == 'game' and autosave_settings ~= false and autosave_settings ~= 'exit' then
        local time_autosave = 0
        if autosave_settings == '5min' then
            time_autosave = 300
        elseif autosave_settings == '10min' then
            time_autosave = 600
        else
            time_autosave = 1800
        end
        if autosave_timer + time_autosave < love.timer.getTime() then
            funcs.save_map(data.map_name)
            funcs.create_message(player, "Карта автоматически сохранена!", 4, 0, 255, 80)
            autosave_timer = love.timer.getTime()
        end
    end
end

function update.all()
    if data.multiplayer.enet_type ~= "host" then
        update.mouse()
        update.player()
        keyboard.update()
        gui.update()
        planets = update.planet(data.planet, planets)
        update.autosave()
    end
end

return update