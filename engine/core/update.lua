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
local multiplayer = require("engine/modules/multiplayer/multiplayer")
local players = require("engine/modules/multiplayer/players")

local update_planet_timer = love.timer.getTime()
local update_player_moving_timer = love.timer.getTime()
local autosave_timer = love.timer.getTime()
local tps_timer = love.timer.getTime()


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

function update.blocks()
    local planet = planets[data.planet]
    local h = planet.h
    local w = planet.w
    local subtick_h = h / 10 --Высота, которую игра будет обрабатывать за один сабтик
    local start_h = h - subtick_h * planet.subtick --Высота, с которой начинается обновление

    for x = 1, w do
        for y = start_h, start_h - subtick_h + 1, -1 do
            if blocks[planets[data.planet].map[x][y].block].multiblock == nil then
                local old_img_num = planets[data.planet].map[x][y].img_num
                planets[data.planet].map[x][y].img_num = funcs.select_block_img(planets[data.planet].map, x, y, planets[data.planet].h, planets[data.planet].w)
                if planets[data.planet].map[x][y].img_num ~= old_img_num then
                    funcs.host_change_block(x, y)
                end
            else
                local multiblock = planets[data.planet].map[x][y].multiblock
                planets[data.planet].map[x][y].img_num = multiblock.y_in_block * 8 + multiblock.x_in_block + 1
                local block = planets[data.planet].map[x][y].block
                if multiblock.x_in_block == 0 and multiblock.y_in_block == 0 then
                    update.multiblock(planets[data.planet].map[x][y].block, x, y, w, h)
                elseif planets[data.planet].map[multiblock.x][multiblock.y].block ~= planets[data.planet].map[x][y].block then
                    for xi = 0, blocks[block].multiblock.w - 1 do
                        for yi = 0, blocks[block].multiblock.h - 1 do
                            planets[data.planet].map[multiblock.x + xi][multiblock.y + yi].block = 'air'
                            funcs.host_change_block(multiblock.x + xi, multiblock.y + yi)
                        end
                    end
                end
            end
            if planets[data.planet].map[x][y].fire ~= nil then
                if love.math.random() >= 0.4 then
                    local orientation = love.math.random(4)
                    if orientation == 1 and blocks[planets[data.planet].map[funcs.coordx(x - 1, h, w)][y].block].flammability ~= nil then
                        planets[data.planet].map[funcs.coordx(x - 1, h, w)][y].fire = true
                        funcs.host_change_block(funcs.coordx(x - 1, h, w), y)
                    elseif orientation == 2 and blocks[planets[data.planet].map[x][funcs.coordy(y + 1, h, w)].block].flammability ~= nil then
                        planets[data.planet].map[x][funcs.coordy(y + 1, h, w)].fire = true
                        funcs.host_change_block(x, funcs.coordy(y + 1, h, w))
                    elseif orientation == 3 and blocks[planets[data.planet].map[funcs.coordx(x + 1, h, w)][y].block].flammability ~= nil then
                        planets[data.planet].map[funcs.coordx(x + 1, h, w)][y].fire = true
                        funcs.host_change_block(funcs.coordy(x + 1, h, w), y)
                    elseif orientation == 4 and blocks[planets[data.planet].map[x][funcs.coordy(y - 1, h, w)].block].flammability ~= nil then
                        planets[data.planet].map[x][funcs.coordy(y - 1, h, w)].fire = true
                        funcs.host_change_block(x, funcs.coordy(y - 1, h, w))
                    end
                end
                if love.math.random() >= blocks[planets[data.planet].map[x][y].block].flammability then
                    planets[data.planet].map[x][y].fire = nil
                    if blocks[planets[data.planet].map[x][y].block].combustion_product ~= nil then
                        planets[data.planet].map[x][y].block = blocks[planets[data.planet].map[x][y].block].combustion_product
                        funcs.host_change_block(x, y)
                    else
                        planets[data.planet].map[x][y].block = 'air'
                        funcs.host_change_block(x, y)
                    end
                    planets[data.planet].map[x][y].destruction = 0
                end
            end
        end
    end
end
      
function update.planet()
    if update_planet_timer + 0.02 < love.timer.getTime() then
        update_planet_timer = love.timer.getTime()
        if data.multiplayer.enet_type ~= "client" then
            physics.update()
            update.blocks()
        end

        planets[data.planet].subtick = planets[data.planet].subtick + 1

        if planets[data.planet].subtick == 10 then
            light.update()
            planets[data.planet].subtick = 0
            planets[data.planet].ticks = planets[data.planet].ticks + 1
            data.tps = data.tps + 1
        end
    end
    if data.multiplayer.enet_type ~= "client" then
        if tps_timer + 5 < love.timer.getTime() then
            data.tps_display = data.tps / 5
            data.tps = 0
            tps_timer = love.timer.getTime()
        end
    end
end

function update.player()
    local width, height = love.graphics.getDimensions()
    player.camera.x = (player.x * 24 - width / 2) / player.camera.zoom
    player.camera.y = (player.y * 24 - height / 2) / player.camera.zoom

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
                player.x = player.x + 0.4
            end
            if player.moving.left == true then
                player.x = player.x - 0.4
            end
            if player.moving.up == true then
                player.y = player.y - 0.4
            end
            if player.moving.down == true then
                player.y = player.y + 0.4
            end

            player.x, player.y = funcs.player_coords_loop(player.x, player.y, planets[data.planet].w, planets[data.planet].h)
            
            -- if collision.player(player.x, player.y + 0.4, planets[data.planet]) == false then
            --     player.y = player.y + 0.4
            -- elseif collision.player(player.x, player.y + 0.2, planets[data.planet]) == false then
            --     player.y = player.y + 0.2
            -- elseif collision.player(player.x, player.y + 0.05, planets[data.planet]) == false then
            --     player.y = player.y + 0.05
            -- elseif collision.player(player.x, player.y + 0.01, planets[data.planet]) == false then
            --     player.y = math.floor(player.y)
            -- end

            --planets.pcore.map[math.ceil(player.x)][math.ceil(player.y)].block = "glass"

            if data.multiplayer.enet_type == "client" then
                for nickname, player_net in pairs(players.pseudo) do
                    local diff_x = players.new[nickname].x - players.old[nickname].x
                    local diff_y = players.new[nickname].y - players.old[nickname].y
                    local diff_pseudo_x = players.new[nickname].x - players.pseudo[nickname].x
                    local diff_pseudo_y = players.new[nickname].y - players.pseudo[nickname].y

                    if math.abs(diff_pseudo_x) > math.abs(diff_x / 8) then
                        players.pseudo[nickname].x = players.pseudo[nickname].x + diff_x / 9
                    else
                        players.pseudo[nickname].x = players.new[nickname].x
                    end

                    if math.abs(diff_pseudo_y) > math.abs(diff_y / 8) then
                        players.pseudo[nickname].y = players.pseudo[nickname].y + diff_y / 9
                    else
                        players.pseudo[nickname].y = players.new[nickname].y
                    end
                end
            end
            
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
    if data.multiplayer.enet_type ~= nil then
        multiplayer.update()
    end

    if data.multiplayer.enet_type ~= "host" then
        update.mouse()
        update.player()
        keyboard.update()
        gui.update()
    end
    update.planet()
    update.autosave()
end

return update