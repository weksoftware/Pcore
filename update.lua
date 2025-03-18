local funcs = require("level_two/funcs")
local blocks = require("level_three/blocks")
local data = require("level_three/data")
local planets = require("level_three/planets")
local keyboard = require("level_two/keyboard")
local light = require("level_two/light")
local physics = require("level_two/physics")

local update_planet_timer = love.timer.getTime()

local update = {}

function update.multiblock(block, x, y)
    local exists = true
    local w = blocks[block].multiblock.w
    local h = blocks[block].multiblock.h
    for xi = 0, w - 1 do
        for yi = 0, h - 1 do
            if block ~= planets[data.planet].map[x + xi][y + yi].block then
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
                planets[data.planet].map[x][y].img_num = planets[data.planet].map[x][y].multiblock.num
                local multiblock = planets[data.planet].map[x][y].multiblock
                local block = planets[data.planet].map[x][y].block
                if multiblock.num == 1 then
                    update.multiblock(planets[data.planet].map[x][y].block, x, y)
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

function update.all()
    keyboard.update()
    update.planet()
end

return update