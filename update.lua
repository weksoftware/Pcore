local funcs = require("level_two/funcs")
local blocks = require("level_three/blocks")
local data = require("level_three/data")
local player = require("level_three/player")
local planets = require("level_three/planets")
local keyboard = require("level_two/keyboard")
local light = require("level_two/light")
local physics = require("level_two/physics")
local fonts = require("level_three/fonts")
local gui = require("level_two/gui")
local items = require("level_two/items")
local items_funcs = require("level_two/items_funcs")

local update_planet_timer = love.timer.getTime()
local update_player_moving_timer = love.timer.getTime()
local autosave_timer = love.timer.getTime()

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
                planets[data.planet].map[x][y].img_num = funcs.select_block_img(planets[data.planet].map, x, y, planets[data.planet].h, planets[data.planet].w)
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
                        end
                    end
                end
            end
            if planets[data.planet].map[x][y].fire ~= nil then
                if love.math.random() >= 0.4 then
                    local orientation = love.math.random(4)
                    if orientation == 1 and blocks[planets[data.planet].map[funcs.coordx(x - 1, h, w)][y].block].flammability ~= nil then
                        planets[data.planet].map[funcs.coordx(x - 1, h, w)][y].fire = true
                    elseif orientation == 2 and blocks[planets[data.planet].map[x][funcs.coordy(y + 1, h, w)].block].flammability ~= nil then
                        planets[data.planet].map[x][funcs.coordy(y + 1, h, w)].fire = true
                    elseif orientation == 3 and blocks[planets[data.planet].map[funcs.coordx(x + 1, h, w)][y].block].flammability ~= nil then
                        planets[data.planet].map[funcs.coordx(x + 1, h, w)][y].fire = true
                    elseif orientation == 4 and blocks[planets[data.planet].map[x][funcs.coordy(y - 1, h, w)].block].flammability ~= nil then
                        planets[data.planet].map[x][funcs.coordy(y - 1, h, w)].fire = true
                    end
                end
                if love.math.random() >= blocks[planets[data.planet].map[x][y].block].flammability then
                    planets[data.planet].map[x][y].fire = nil
                    if blocks[planets[data.planet].map[x][y].block].combustion_product ~= nil then
                        planets[data.planet].map[x][y].block = blocks[planets[data.planet].map[x][y].block].combustion_product
                    else
                        planets[data.planet].map[x][y].block = 'air'
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
        physics.update()
        update.blocks()

        planets[data.planet].subtick = planets[data.planet].subtick + 1

        if planets[data.planet].subtick == 10 then
            light.update()
            planets[data.planet].subtick = 0
            planets[data.planet].ticks = planets[data.planet].ticks + 1
        end
    end
end

function update.player()
    if player.moving ~= nil and update_player_moving_timer + 0.01 < love.timer.getTime() then
        if player.moving.right == true then
            player.x = player.x + 15
        end
        if player.moving.left == true then
            player.x = player.x - 15
        end
        if player.moving.up == true then
            player.y = player.y - 15
        end
        if player.moving.down == true then
            player.y = player.y + 15
        end
        update_player_moving_timer = love.timer.getTime()
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
    update.mouse()
    update.player()
    keyboard.update()
    gui.update()
    update.planet()
    update.autosave()
end

return update