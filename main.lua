local display = require("engine/core/display")
local update = require("engine/core/update")
local start = require("engine/core/start")

function love.load(arg)
    start.game()
end

function love.update(dt)
    update.all()
end

function love.draw()
    display.all()
end