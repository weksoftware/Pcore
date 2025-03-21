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

local update_planet_timer = love.timer.getTime()
local update_player_moving_timer = love.timer.getTime()

local update = {}

function love.resize(w, h)
    fonts.load_fonts()
end

function love.mousepressed(x, y, button, istouch, presses)
    if button == 1 then
        data.mouse.x = x
        data.mouse.y = y
    end
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
    local h = planets[data.planet].h
    local w = planets[data.planet].w

    for x = 1, w do
        for y = 1, h do
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
                end
            end

        end
    end
end
      
function update.planet()
    if update_planet_timer + 0.1 < love.timer.getTime() then
        physics.update()
        update.blocks()
        light.update()
        planets[data.planet].ticks = planets[data.planet].ticks + 1
        update_planet_timer = love.timer.getTime()
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
end

function update.all()
    update.player()
    keyboard.update()
    gui.update()
    update.planet()
end

return update