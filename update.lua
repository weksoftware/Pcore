local funcs = require("level_two/funcs")
local blocks = require("level_three/blocks")
local data = require("level_three/data")
local planets = require("level_three/planets")
local keyboard = require("level_two/keyboard")
local light = require("level_two/light")
local liquid = require("level_two/liquid")

local update_planet_timer = os.clock()

local update = {}

function update.blocks()
    local h = planets[data.planet].h
    local w = planets[data.planet].w

    for x = 1, w do
        for y = 1, h do

            if planets[data.planet].map[x][y].tick < planets[data.planet].ticks and blocks[planets[data.planet].map[x][y].block].physics_type == 'powder' and (blocks[planets[data.planet].map[x][funcs.coordy(y + 1, h, w)].block].physics_type == 'air' or blocks[planets[data.planet].map[x][funcs.coordy(y + 1, h, w)].block].physics_type == 'liquid') then
                local block1 = planets[data.planet].map[x][y].block
                local block2 = planets[data.planet].map[x][funcs.coordy(y + 1, h, w)].block
                planets[data.planet].map[x][funcs.coordy(y + 1, h, w)].block = block1
                planets[data.planet].map[x][funcs.coordy(y + 1, h, w)].tick = planets[data.planet].ticks
                planets[data.planet].map[x][y].block = block2

            elseif planets[data.planet].map[x][y].tick < planets[data.planet].ticks and blocks[planets[data.planet].map[x][y].block].physics_type == 'liquid' and blocks[planets[data.planet].map[x][funcs.coordy(y + 1, h, w)].block].physics_type == 'air' then
                local block1 = planets[data.planet].map[x][y].block
                local block2 = planets[data.planet].map[x][funcs.coordy(y + 1, h, w)].block
                planets[data.planet].map[x][funcs.coordy(y + 1, h, w)].block = block1
                planets[data.planet].map[x][funcs.coordy(y + 1, h, w)].tick = planets[data.planet].ticks
                planets[data.planet].map[x][y].block = block2
            
            elseif planets[data.planet].map[x][y].tick < planets[data.planet].ticks and blocks[planets[data.planet].map[x][y].block].physics_type == 'liquid' and planets[data.planet].map[x][y].pressure >= 0 then
                local voids = {}
                local voids_len = 0
                if planets[data.planet].map[funcs.coordx(x - 1, h, w)][y].block == 'air' then
                    table.insert(voids, {['x']=funcs.coordx(x - 1, h, w), ['y']=y})
                    voids_len = voids_len + 1
                end
                if planets[data.planet].map[funcs.coordx(x + 1, h, w)][y].block == 'air' then
                    table.insert(voids, {['x']=funcs.coordx(x + 1, h, w), ['y']=y})
                    voids_len = voids_len + 1
                end
                if planets[data.planet].map[x][funcs.coordy(y - 1, h, w)].block == 'air' and planets[data.planet].map[x][funcs.coordy(y + 1, h, w)].block ~= 'air' and planets[data.planet].map[x][y].pressure >= 300 then
                    table.insert(voids, {['x']=x, ['y']=funcs.coordy(y - 1, h, w)})
                    voids_len = voids_len + 1
                end

                if voids_len > 0 then
                    local coords = voids[math.random(1, voids_len)]
                    local block1 = planets[data.planet].map[x][y]
                    local block2 = planets[data.planet].map[coords.x][coords.y]
                    planets[data.planet].map[x][y] = block2
                    planets[data.planet].map[coords.x][coords.y] = block1
                    planets[data.planet].map[coords.x][coords.y].tick = planets[data.planet].ticks
                end
            end

        end
    end
end
      
function update.planet()
    if update_planet_timer + 0.05 < os.clock() then
        liquid.update()
        update.blocks()
        light.update()
        planets[data.planet].ticks = planets[data.planet].ticks + 1
        update_planet_timer = os.clock()
    end
end

function update.all()
    keyboard.update()
    update.planet()
end

return update