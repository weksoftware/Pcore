local player = require("level_three/player")
local data = require("level_three/data")
local planets = require("level_three/planets")
local funcs = require("level_two/funcs")
local gui = {}

local cursor = funcs.img_load("textures/cursor.png")
local font1 = love.graphics.newFont("fonts/basis33/regular.ttf", 48)

function gui.display()
    if data.display_debug == true then
        love.graphics.print('x: ' .. math.floor(player.x / 96) .. ' / y: ' .. math.floor(player.y / 96), font1, 40, 80)
        love.graphics.print(planets[data.planet].ticks .. ' ticks', font1, 40, 120)
        love.graphics.print(player.camera.zoom .. ' zoom', font1, 40, 160)
        love.graphics.print('block: ' .. data.blocks_for_building[data.block], font1, 40, 220)
    end

    local mx, my = love.mouse.getPosition()
    love.graphics.draw(cursor, mx - 14, my - 14, nil, 2)
end 

return gui