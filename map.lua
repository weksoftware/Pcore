local blocks = require("blocks")

local map = {}

function map.generation(type)
    local planet = {}

    planet.map = {}

    planet.w = 1024
    planet.h = 128
    planet.ticks = 0

    if type == "debug" then

        for x = 1, planet.w do
            planet.map[x] = {}
            for y = 1, planet.h do
                planet.map[x][y] = {}
                if y < 40 then
                    planet.map[x][y].block = "air"
                elseif y < 55 then
                    planet.map[x][y].block = "water"
                elseif y < 57 then
                    planet.map[x][y].block = "sand"
                else
                    planet.map[x][y].block = "clay"
                end
                if x == 1 then
                    planet.map[x][y].block = "glass"
                end
                planet.map[x][y].tick = 0
                planet.map[x][y].pressure = 0
            end
        end

    elseif type == "debug1" then
        local water_h = 64
        local seed = 4.0
        for x = 1, planet.w do
            planet.map[x] = {}
            for y = 1, planet.h do
                planet.map[x][y] = {}
                planet.map[x][y].tick = 0
                planet.map[x][y].pressure = 0
                planet.map[x][y].background = 'air'
                planet.map[x][y].light = 256

                noise1 = love.math.noise(x / 256 + 0.0001, seed)
                noise2 = love.math.noise(x / 32 + 0.0001, seed)
                noise3 = love.math.noise(x / 8 + 0.0001, seed)
                noise = planet.h - (noise1 * 70 + noise2 * 8 + noise3 * 2 + 24)
                if noise < y then
                    if y - noise <= 8 and y > water_h - 5 and noise > water_h - 5 then 
                        planet.map[x][y].block = 'sand'
                    else
                        planet.map[x][y].block = 'clay'
                    end
                else
                    if y <= water_h then
                        planet.map[x][y].block = 'air'
                    else
                        planet.map[x][y].block = 'water'
                    end
                end
            end
        end

    elseif type == "start" then

        for x = 1, planet.w do
            planet.map[x] = {}
            for y = 1, planet.h do
                planet.map[x][y] = {}
                planet.map[x][y].tick = 0
                planet.map[x][y].pressure = 0
                planet.map[x][y].background = 'air'
                planet.map[x][y].light = 256
                planet.map[x][y].block = 'air'
            end
        end
    end

    return planet
end

return map
