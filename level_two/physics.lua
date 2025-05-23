local planets = require("level_three/planets")
local data = require("level_three/data")
local blocks = require("level_three/blocks")
local funcs = require("level_two/funcs")

local physics = {}

function physics.update()
    local planet = planets[data.planet]
    local h = planet.h
    local w = planet.w
    local subtick_h = h / 10 --Высота, которую игра будет обрабатывать за один сабтик
    local start_h = h - subtick_h * planet.subtick --Высота, с которой начинается обновление

    for x = 1, w do
        for y = start_h, start_h - subtick_h + 1, -1 do
            if planet.map[x][y].tick < planet.ticks then
                if blocks[planet.map[x][y].block].physics_type == 'liquid' then
                    if planet.map[x][funcs.coordy(y + 1, h, w)].block == 'air' then
                        planet.map[x][funcs.coordy(y + 1, h, w)].block = planet.map[x][y].block
                        planet.map[x][funcs.coordy(y + 1, h, w)].tick = planet.ticks
                        planet.map[x][y].block = 'air'
                        planet.map[x][y].fire = nil

                    else
                        local orientation = love.math.random(2)
                        if orientation == 1 and planet.map[funcs.coordx(x - 1,h, w)][y].block == 'air' then
                            planet.map[funcs.coordx(x - 1,h, w)][y].block = planet.map[x][y].block
                            planet.map[funcs.coordx(x - 1,h, w)][y].tick = planet.ticks
                            planet.map[x][y].block = 'air'
                            planet.map[x][y].fire = nil
                        elseif orientation == 2 and planet.map[funcs.coordx(x + 1,h, w)][y].block == 'air' then
                            planet.map[funcs.coordx(x + 1,h, w)][y].block = planet.map[x][y].block
                            planet.map[funcs.coordx(x + 1,h, w)][y].tick = planet.ticks
                            planet.map[x][y].block = 'air'
                            planet.map[x][y].fire = nil
                        end
                    end
                elseif blocks[planet.map[x][y].block].physics_type == 'powder' then
                    if planet.map[x][funcs.coordy(y + 1, h, w)].block == 'air' then
                        planet.map[x][funcs.coordy(y + 1, h, w)].block = planet.map[x][y].block
                        planet.map[x][funcs.coordy(y + 1, h, w)].destruction = planet.map[x][y].destruction
                        planet.map[x][funcs.coordy(y + 1, h, w)].tick = planet.ticks
                        planet.map[x][y].block = 'air'
                        planet.map[x][y].destruction = 0
                        planet.map[x][y].fire = nil
                    elseif blocks[planet.map[x][funcs.coordy(y + 1, h, w)].block].physics_type == 'liquid' then
                        local block = planet.map[x][funcs.coordy(y + 1, h, w)].block
                        planet.map[x][funcs.coordy(y + 1, h, w)].block = planet.map[x][y].block
                        planet.map[x][funcs.coordy(y + 1, h, w)].destruction = planet.map[x][y].destruction
                        planet.map[x][funcs.coordy(y + 1, h, w)].tick = planet.ticks
                        planet.map[x][y].block = block
                        planet.map[x][y].destruction = 0
                        planet.map[x][y].fire = nil
                    else
                        local orientation = love.math.random(2)
                        if orientation == 1 and planet.map[funcs.coordx(x - 1,h, w)][funcs.coordy(y + 1, h, w)].block == 'air' then
                            planet.map[funcs.coordx(x - 1,h, w)][funcs.coordy(y + 1, h, w)].block = planet.map[x][y].block
                            planet.map[funcs.coordx(x - 1,h, w)][funcs.coordy(y + 1, h, w)].destruction = planet.map[x][y].destruction
                            planet.map[funcs.coordx(x - 1,h, w)][funcs.coordy(y + 1, h, w)].tick = planet.ticks
                            planet.map[x][y].block = 'air'
                            planet.map[x][y].destruction = 0
                            planet.map[x][y].fire = nil
                        elseif orientation == 2 and planet.map[funcs.coordx(x + 1,h, w)][funcs.coordy(y + 1, h, w)].block == 'air' then
                            planet.map[funcs.coordx(x + 1,h, w)][funcs.coordy(y + 1, h, w)].block = planet.map[x][y].block
                            planet.map[funcs.coordx(x + 1,h, w)][funcs.coordy(y + 1, h, w)].destruction = planet.map[x][y].destruction
                            planet.map[funcs.coordx(x + 1,h, w)][funcs.coordy(y + 1, h, w)].tick = planet.ticks
                            planet.map[x][y].block = 'air'
                            planet.map[x][y].destruction = 0
                            planet.map[x][y].fire = nil
                        end
                    end
                elseif blocks[planet.map[x][y].block].physics_type == 'gas' then
                    if planet.map[x][funcs.coordy(y - 1, h, w)].block == 'air' then
                        planet.map[x][funcs.coordy(y - 1, h, w)].block = planet.map[x][y].block
                        planet.map[x][funcs.coordy(y - 1, h, w)].tick = planet.ticks
                        planet.map[x][y].block = 'air'
                        planet.map[x][y].fire = nil

                    else
                        local orientation = love.math.random(2)
                        if orientation == 1 and planet.map[funcs.coordx(x - 1,h, w)][y].block == 'air' then
                            planet.map[funcs.coordx(x - 1,h, w)][y].block = planet.map[x][y].block
                            planet.map[funcs.coordx(x - 1,h, w)][y].tick = planet.ticks
                            planet.map[x][y].block = 'air'
                            planet.map[x][y].fire = nil
                        elseif orientation == 2 and planet.map[funcs.coordx(x + 1,h, w)][y].block == 'air' then
                            planet.map[funcs.coordx(x + 1,h, w)][y].block = planet.map[x][y].block
                            planet.map[funcs.coordx(x + 1,h, w)][y].tick = planet.ticks
                            planet.map[x][y].block = 'air'
                            planet.map[x][y].fire = nil
                        end
                    end
                end
            end
        end
    end



    planets[data.planet] = planet
end

return physics