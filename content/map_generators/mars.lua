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

    local seed = 4.0

    local noise = {}

    for x = 1, planet.w do
        planet.map[x] = {}
        local noise1 = love.math.noise(x / 512 + 0.0001, seed)
        local noise2 = love.math.noise(x / 64 + 0.0001, seed)
        local noise3 = love.math.noise(x / 16 + 0.0001, seed)
        noise[x] = planet.h - (noise1 * 40 + noise2 * 8 + noise3 * 2 + 40)
        for y = 1, planet.h do
            local noise_ice = love.math.noise(x / 12 + 0.0001, y / 12 + 0.0001, seed)
            planet.map[x][y] = {}
            planet.map[x][y].tick = 0
            planet.map[x][y].pressure = 0
            planet.map[x][y].background = 'air'
            planet.map[x][y].light = 256
            planet.map[x][y].img_num = 1
            planet.map[x][y].destruction = 0

            if noise[x] < y then
                if y - noise[x] <= 10 then
                    planet.map[x][y].block = 'martian_dense_regolith'
                    if y - noise[x] <= 4 then
                        planet.map[x][y].block = 'martian_regolith'
                    end
                else
                    planet.map[x][y].block = 'martian_stone'
                    planet.map[x][y].background = 'martian_stone'
                    if noise_ice > 0.7 and planet.h - y > 5 then
                        planet.map[x][y].block = 'ice'
                    end
                end
            else
                planet.map[x][y].block = 'air'
            end
        end
    end

    for x = 1, planet.w do
        if love.math.random() > 0.99 then
            planet = structures.nature.crater(x, math.floor(noise[x]), noise, planet)
        end
    end


    return planet
end

return generate