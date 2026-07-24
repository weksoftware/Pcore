local structures = {}

function structures.cypress(x, y, h, planet)

    if x > 3 and x < planet.w - 3 and y > h then
        if planet.map[x-1][y-3].background == "air" and planet.map[x+1][y-3].background == "air" then
            for i = y + 5, y - h - 1, -1 do
                if i >= 1 and i < planet.h then
                    planet.map[x][i].background = 'cypress_wood'
                    if i < y - 5 then
                        planet.map[x][i].block = 'cypress_leaves'
                        planet.map[x-1][i].block = 'cypress_leaves'
                        planet.map[x+1][i].block = 'cypress_leaves'
                        if i < y - 7 and i > y - h - 1 then
                            planet.map[x-2][i].block = 'cypress_leaves'
                            planet.map[x+2][i].block = 'cypress_leaves'
                        end
                    end
                end
            end
        end
    end

    return planet
end

function structures.crater(x, y, noise, planet)

    for xf = -20, 20 do
        if x + xf > 1 and x + xf < planet.w then
            local f = 15 - (xf/6)^2
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

return structures