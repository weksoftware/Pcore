local funcs = require("engine/core/funcs")

local collision = {}

function collision.player(player_x, player_y, planet)

    local x = math.ceil(player_x)
    local y = math.ceil(player_y)

    if planet.map[x][funcs.coordy(y + 1, planet.h, planet.w)].block ~= "air" then
        return true
    elseif player_x % 1 > 0.5 and planet.map[funcs.coordx(x + 1, planet.h, planet.w)][funcs.coordy(y + 1, planet.h, planet.w)].block ~= "air" then
        return true
    elseif player_x % 1 < 0.5 and planet.map[funcs.coordx(x - 1, planet.h, planet.w)][funcs.coordy(y + 1, planet.h, planet.w)].block ~= "air" then
        return true
    else
        return false
    end

end

function collision.player2(player_x, player_y, planet)

    local x = math.ceil(player_x)
    local y = math.ceil(player_y)

    for xi = -1, 1 do
        for yi = -2, 2 do
            return false
        end
    end

end

return collision