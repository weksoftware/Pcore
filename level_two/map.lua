local blocks = require("level_three/blocks")

local map = {}

function map.gen_cypress(x, y, h, planet)
    local err = false
    if y + 1 < planet.h and x > 1 and x < planet.w then
        if planet.map[x-1][y+1].block == 'air' or planet.map[x+1][y+1].block == 'air' then
            err = true
        end
    end
    for i = y, y - h - 1, -1 do
        if i < planet.h - 5 and x > 5 and x < planet.w then
            if planet.map[x-1][i].background == 'air' and planet.map[x+1][i].background == 'air' and err == false then
                planet.map[x][i].background = 'cypress_wood'
                
                if i < y - 3 then
                    planet.map[x][i].block = 'cypress_leaves'
                    planet.map[x-1][i].block = 'cypress_leaves'
                    planet.map[x+1][i].block = 'cypress_leaves'
                    if i < y - 4 and i > y - 10 then
                        planet.map[x-2][i].block = 'cypress_leaves'
                        planet.map[x+2][i].block = 'cypress_leaves'
                    end
                end
                if i == y - 11 then
                    planet.map[x][i].block = 'cypress_leaves'
                end
            else
                err = true
            end
        end
    end
    return planet
end

function map.gen_crater(x, y, noise, planet)

    for xf = -20, 20 do
        if x + xf > 1 and x + xf < planet.w then
            local f = 7 - (xf/8)^2
            for yf = 1, planet.h do
                if yf < noise[x + xf] + f then
                    planet.map[x + xf][yf].block = 'air'
                    if xf > -3 and xf < 3 and yf > noise[x + xf] + f - 2 then
                        planet.map[x + xf][yf].block = 'meteorite'
                    end
                elseif yf < noise[x + xf] + f + 5 and planet.map[x + xf][yf].block ~= 'air' then
                    planet.map[x + xf][yf].block = 'martian_stone'
                end
            end
        end
    end

    return planet
end

function map.generation(type)
    local planet = {}

    planet.map = {}

    planet.w = 2048
    planet.h = 128
    planet.ticks = 0

    if type == "pcore" then
        local water_h = 64
        local seed = 4.0

        local noise = {}

        for x = 1, planet.w do
            planet.map[x] = {}
            local noise1 = love.math.noise(x / 256 + 0.0001, seed)
            local noise2 = love.math.noise(x / 32 + 0.0001, seed)
            local noise3 = love.math.noise(x / 8 + 0.0001, seed)
            noise[x] = planet.h - (noise1 * 70 + noise2 * 8 + noise3 * 2 + 24)
            for y = 1, planet.h do
                local noise_methane = love.math.noise(x / 58 + 0.0001, y / 58 + 0.0001, seed)

                planet.map[x][y] = {}
                planet.map[x][y].tick = 0
                planet.map[x][y].pressure = 0
                planet.map[x][y].background = 'air'
                planet.map[x][y].light = 256
                planet.map[x][y].img_num = 1

                if noise[x] < y then
                    if y - noise[x] <= 8 and y > water_h - 5 and noise[x] > water_h - 5 then 
                        planet.map[x][y].block = 'sand'
                    elseif y - noise[x] <= 30 then
                        planet.map[x][y].block = 'clay'
                        if y - noise[x] <= 15 then
                            planet.map[x][y].block = 'dirt'
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
                    if y <= water_h then
                        planet.map[x][y].block = 'air'
                    else
                        planet.map[x][y].block = 'water'
                    end
                end
            end
        end

        for x = 1, planet.w do
            if noise[x] < water_h - 5 then
                if love.math.random() > 0.8 then
                    planet = map.gen_cypress(x, math.floor(noise[x]), 10, planet)
                end
            end
        end

    elseif type == "mars" then
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
                planet = map.gen_crater(x, math.floor(noise[x]), noise, planet)
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
