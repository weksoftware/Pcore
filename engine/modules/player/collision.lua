local collision = {}

function collision.player(player_x, player_y, map, zoom)

    local x = math.ceil(player_x / 24 / zoom)
    local y = math.ceil(player_y / 24 / zoom)

    if map[x][y + 1].block ~= "air" then
        return true
    elseif player_x % 24 > 12 and map[x + 1][y + 1].block ~= "air" then
        return true
    elseif player_x % 24 < 12 and map[x - 1][y + 1].block ~= "air" then
        return true
    else
        return false
    end

end

return collision