local funcs = require("funcs")
local blocks = require("blocks")
local data = require("data")

local update_planet_timer = os.clock()

local update = {}

function update.liquid(planet)
    local h = planet.h
    local w = planet.w

    for x = 1, w do
        local pressure = 0
        for y = 1, h do
            if blocks[planet.map[x][y].block].physics_type ~= 'liquid' then
                pressure = 0
                planet.map[x][y].pressure = pressure
            else
                planet.map[x][y].pressure = pressure
                pressure = pressure + 1
            end
        end
    end

    for x = 1, w do
        for y = 1, h do
            if blocks[planet.map[x][y].block].physics_type == 'liquid' and planet.map[x][y].pressure >= 1 then
                if blocks[planet.map[funcs.coordx(x + 1, h, w)][y].block].physics_type == 'liquid' and planet.map[funcs.coordx(x + 1, h, w)][y].pressure < planet.map[x][y].pressure then
                    planet.map[funcs.coordx(x + 1, h, w)][y].pressure = planet.map[x][y].pressure
                end
            end
        end
    end

    for x = w, 1, -1 do
        for y = 1, h do
            if blocks[planet.map[x][y].block].physics_type == 'liquid' and planet.map[x][y].pressure >= 1 then
                if blocks[planet.map[funcs.coordx(x - 1, h, w)][y].block].physics_type == 'liquid' and planet.map[funcs.coordx(x - 1, h, w)][y].pressure < planet.map[x][y].pressure then
                    planet.map[funcs.coordx(x - 1, h, w)][y].pressure = planet.map[x][y].pressure
                end
            end
        end
    end

    -- for x = 1, w do
    --     for y = 1, h do
    --         if blocks[planet.map[x][y].block].physics_type == 'liquid' and planet.map[x][y].pressure > 0 and planet.map[x][funcs.coordy(y - 1, h, w)].block == 'air' and planet.map[x][funcs.coordy(y + 1, h, w)].block ~= 'air' then
    --             local block1 = planet.map[x][y]
    --             local block2 = planet.map[x][funcs.coordy(y - 1, h, w)]

    --             planet.map[x][y] = block2
    --             planet.map[x][funcs.coordy(y - 1, h, w)] = block1
    --         end
    --     end
    -- end

    return planet
end

function update.light(planet)
    local h = planet.h
    local w = planet.w

    lights = {x = 0, y = 0, radius = 1}

    for x = 1, w do

        local light = 1

        for y = 1, h do
            if planet.map[x][y].block ~= 'air' then
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

    return planet
end
            

function update.planet(planet)

    --planet = update.liquid(planet)

    if update_planet_timer + 0.05 < os.clock() then
        local h = planet.h
        local w = planet.w

        for x = 1, w do
            for y = 1, h do

                if planet.map[x][y].tick < planet.ticks and blocks[planet.map[x][y].block].physics_type == 'powder' and (blocks[planet.map[x][funcs.coordy(y + 1, h, w)].block].physics_type == 'air' or blocks[planet.map[x][funcs.coordy(y + 1, h, w)].block].physics_type == 'liquid') then
                    local block1 = planet.map[x][y].block
                    local block2 = planet.map[x][funcs.coordy(y + 1, h, w)].block
                    planet.map[x][funcs.coordy(y + 1, h, w)].block = block1
                    planet.map[x][funcs.coordy(y + 1, h, w)].tick = planet.ticks
                    planet.map[x][y].block = block2

                elseif planet.map[x][y].tick < planet.ticks and blocks[planet.map[x][y].block].physics_type == 'liquid' and blocks[planet.map[x][funcs.coordy(y + 1, h, w)].block].physics_type == 'air' then
                    local block1 = planet.map[x][y].block
                    local block2 = planet.map[x][funcs.coordy(y + 1, h, w)].block
                    planet.map[x][funcs.coordy(y + 1, h, w)].block = block1
                    planet.map[x][funcs.coordy(y + 1, h, w)].tick = planet.ticks
                    planet.map[x][y].block = block2
                
                elseif planet.map[x][y].tick < planet.ticks and blocks[planet.map[x][y].block].physics_type == 'liquid' and planet.map[x][y].pressure >= 0 then
                    local voids = {}
                    local voids_len = 0
                    if planet.map[funcs.coordx(x - 1, h, w)][y].block == 'air' then
                        table.insert(voids, {['x']=funcs.coordx(x - 1, h, w), ['y']=y})
                        voids_len = voids_len + 1
                    end
                    if planet.map[funcs.coordx(x + 1, h, w)][y].block == 'air' then
                        table.insert(voids, {['x']=funcs.coordx(x + 1, h, w), ['y']=y})
                        voids_len = voids_len + 1
                    end
                    if planet.map[x][funcs.coordy(y - 1, h, w)].block == 'air' and planet.map[x][funcs.coordy(y + 1, h, w)].block ~= 'air' and planet.map[x][y].pressure >= 300 then
                        table.insert(voids, {['x']=x, ['y']=funcs.coordy(y - 1, h, w)})
                        voids_len = voids_len + 1
                    end

                    if voids_len > 0 then
                        local coords = voids[math.random(1, voids_len)]
                        local block1 = planet.map[x][y]
                        local block2 = planet.map[coords.x][coords.y]
                        planet.map[x][y] = block2
                        planet.map[coords.x][coords.y] = block1
                        planet.map[coords.x][coords.y].tick = planet.ticks
                    end
                end

            end
        end

        planet = update.light(planet)

        planet.ticks = planet.ticks + 1
        update_planet_timer = os.clock()
    end

    return planet
end

return update