local funcs = require("engine/core/funcs")

local structures = funcs.require_files("content/structures")

local function generate()

    local planet = {}

    planet.map = {}

    planet.w = 1000
    planet.h = 130
    planet.ticks = 0
    planet.subtick = 0
    planet.game_mode = "normal"
    planet.items = {}

    local seed = 3.0

    local noise = {}

    for x = 1, planet.w do
        if x < planet.w - 50 then
            local noise1 = love.math.noise(x / 256 + 0.0001, seed)
            local noise2 = love.math.noise(x / 32 + 0.0001, seed)
            local noise3 = love.math.noise(x / 8 + 0.0001, seed)
            noise[x] = 80 --planet.h - (noise1 * 70 + noise2 * 8 + noise3 * 2 + 24)
        else
            diff = noise[1] - noise[x-51]
            noise[x] = 80 --noise[1] + (diff / 50) * (x - planet.w)
        end
    end

    for x = 1, planet.w do
        planet.map[x] = {}
        for y = 1, planet.h do
            local noise_methane = love.math.noise(x / 58 + 0.0001, y / 58 + 0.0001, seed)
            planet.map[x][y] = {}
            planet.map[x][y].tick = 0
            planet.map[x][y].pressure = 0
            planet.map[x][y].background = 'air'
            planet.map[x][y].light = 256
            planet.map[x][y].img_num = 1
            planet.map[x][y].destruction = 0

            if noise[x] < y then
                if y - noise[x] <= 30 then
                    planet.map[x][y].block = 'clay'
                    if y - noise[x] <= 15 and  y - noise[x] > 5 then
                        planet.map[x][y].block = 'dirt'
                        planet.map[x][y].background = 'dirt'
                    end
                    if y - noise[x] <= 5 then
                        planet.map[x][y].block = 'grass'
                    end
                else
                    planet.map[x][y].block = 'stone'
                    planet.map[x][y].background = 'stone'
                    if noise_methane > 0.65 and planet.h - y > 5 then
                        planet.map[x][y].block = 'methane'
                    end
                end
            else
                planet.map[x][y].block = 'air'
            end
        end
    end

    for x = 1, planet.w do
        if love.math.random() > 0.95 then
            planet = structures.nature.cypress(x, math.floor(noise[x]), 13, planet)
        end
    end

    return planet
end

return generate