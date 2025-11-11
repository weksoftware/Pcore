local funcs = require("engine/core/funcs")
local physics_types = require("engine/modules/worlds/physics_types")
local blocks = require("engine/modules/worlds/blocks")

local collision = {}

function collision.player(player_x, player_y, planet)

    local startX = math.floor(player_x - 0.375)
    local endX = math.floor(player_x + 0.375)

    local startY = math.floor(player_y - 1)
    local endY = math.floor(player_y + 1)

    for ix = startX, endX do
        for iy = startY, endY do
            if planet.map[ix][iy].block ~= "air" then
                return true
            end
        end
    end

    return false
end

function collision.player2(player_x, player_y, planet)

    local startX = math.floor(player_x - 0.375)
    local endX = math.floor(player_x + 0.375)

    local startY = math.floor(player_y - 1)
    local endY = math.floor(player_y + 1 - 0.001)

    for ix = startX, endX do
        for iy = startY, endY do
            local block_x, block_y = funcs.player_coords_loop(ix, iy, planet.w, planet.h)
            if physics_types[blocks[planet.map[block_x][block_y].block].physics_type].solid == true then
                return true
            end
        end
    end

    return false
end

return collision