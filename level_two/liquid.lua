local liquid = {}

function liquid.update(planet)
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

return liquid