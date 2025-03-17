local planets = require("level_three/planets")
local data = require("level_three/data")
local blocks = require("level_three/blocks")
local funcs = require("level_two/funcs")

local physics = {}

function physics.update()
    local planet = planets[data.planet]
    local h = planet.h
    local w = planet.w

    for x = 1, w do
        for y = h, 1, -1 do
            if planet.map[x][y].tick < planet.ticks then
                if blocks[planet.map[x][y].block].physics_type == 'liquid' then
                    if planet.map[x][funcs.coordy(y + 1, h, w)].block == 'air' then
                        planet.map[x][funcs.coordy(y + 1, h, w)].block = planet.map[x][y].block
                        planet.map[x][funcs.coordy(y + 1, h, w)].tick = planet.ticks
                        planet.map[x][y].block = 'air'

                    else
                        local orientation = love.math.random(2)
                        if orientation == 1 and planet.map[funcs.coordx(x - 1,h, w)][y].block == 'air' then
                            planet.map[funcs.coordx(x - 1,h, w)][y].block = planet.map[x][y].block
                            planet.map[funcs.coordx(x - 1,h, w)][y].tick = planet.ticks
                            planet.map[x][y].block = 'air'
                        elseif orientation == 2 and planet.map[funcs.coordx(x + 1,h, w)][y].block == 'air' then
                            planet.map[funcs.coordx(x + 1,h, w)][y].block = planet.map[x][y].block
                            planet.map[funcs.coordx(x + 1,h, w)][y].tick = planet.ticks
                            planet.map[x][y].block = 'air'
                        end
                    end
                elseif blocks[planet.map[x][y].block].physics_type == 'powder' then
                    if planet.map[x][funcs.coordy(y + 1, h, w)].block == 'air' then
                        planet.map[x][funcs.coordy(y + 1, h, w)].block = planet.map[x][y].block
                        planet.map[x][funcs.coordy(y + 1, h, w)].tick = planet.ticks
                        planet.map[x][y].block = 'air'

                    else
                        local orientation = love.math.random(2)
                        if orientation == 1 and planet.map[funcs.coordx(x - 1,h, w)][funcs.coordy(y + 1, h, w)].block == 'air' then
                            planet.map[funcs.coordx(x - 1,h, w)][funcs.coordy(y + 1, h, w)].block = planet.map[x][y].block
                            planet.map[funcs.coordx(x - 1,h, w)][funcs.coordy(y + 1, h, w)].tick = planet.ticks
                            planet.map[x][y].block = 'air'
                        elseif orientation == 2 and planet.map[funcs.coordx(x + 1,h, w)][funcs.coordy(y + 1, h, w)].block == 'air' then
                            planet.map[funcs.coordx(x + 1,h, w)][funcs.coordy(y + 1, h, w)].block = planet.map[x][y].block
                            planet.map[funcs.coordx(x + 1,h, w)][funcs.coordy(y + 1, h, w)].tick = planet.ticks
                            planet.map[x][y].block = 'air'
                        end
                    end
                end
            end
        end
    end



    planets[data.planet] = planet
end

return physics