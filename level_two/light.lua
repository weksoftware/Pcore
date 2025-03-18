local blocks = require("level_three/blocks")
local funcs = require("level_two/funcs")
local data = require("level_three/data")
local planets = require("level_three/planets")

local light = {}

function light.update()
    local planet = planets[data.planet]
    local h = planet.h
    local w = planet.w

    lights = {x = 0, y = 0, radius = 1}

    for x = 1, w do

        local light = 1

        for y = 1, h do
            if true then
                planet.map[x][y].light = light * 255 + 1

                if blocks[planet.map[x][y].block].transparency <= 1 then
                    
                    if planet.map[x][funcs.coordy(y + 1, h, w)].block == planet.map[x][y].block then
                        light = light * blocks[planet.map[x][y].block].transparency
                    else
                        light = light * blocks[planet.map[x][y].block].shadow
                    end

                else
                    lights.x = x
                    lights.y = y
                    lights.radius = blocks[planet.map[x][y].block].transparency
                end

            else
                planet.map[x][y].light = 256
            end
        end
    end
    
    for x = 1, w do
        for y = 1, h do
            distance = math.sqrt(math.abs(x - lights.x) ^ 2 + math.abs(y - lights.y) ^ 2)
            if distance < lights.radius then
                local light = math.ceil((1 - distance / lights.radius) * 256)
                if planet.map[x][y].light < light then
                    planet.map[x][y].light = light
                end
            end
        end
    end

    planets[data.planet] = planet
end

return light