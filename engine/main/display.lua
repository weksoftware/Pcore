local ms = require("nonengine/libs/multishare")

local d = {}
d.map = require("engine/data/map")
d.camera = require("engine/data/camera")
d.window = require("engine/data/window")
d.player = require("engine/data/player")

local fps = 0
local fps_display = 0
local fps_timer = 0

local display = {}

function display.display()
    d = ms.update(d, "update")
    d = ms.update(d, "controls")
    width, height = love.graphics.getDimensions()
    for x = 1, 80 do
        for y = 1, 60 do
            local color = {r=0, g=0, b=0}
            if d.map.map[x][y].block == "rnd" then
                color = {r=d.map.map[x][y].color, g=d.map.map[x][y].color, b=d.map.map[x][y].color}
            end
            love.graphics.setColor(color.r / 256, color.g / 256, color.b / 256)
            love.graphics.rectangle("fill", (x - 1 - d.camera.coords.x) * d.window.block_size, (y - 1 - d.camera.coords.y) * d.window.block_size, d.window.block_size, d.window.block_size)
            love.graphics.setColor(1, 1, 1)
        end
    end
    love.graphics.setColor(1, 0, 0)
    love.graphics.circle("fill", width / 2, height / 2, d.window.block_size/2)
    love.graphics.setColor(1, 1, 1)
    love.graphics.print(fps_display, 100, 100)

    if fps_timer + 1 < love.timer.getTime() then
        fps_display = fps
        fps = 0
        fps_timer = love.timer.getTime()
    else
        fps = fps + 1
    end
end

return display