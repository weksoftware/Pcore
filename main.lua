local display = require("display")
local update = require("update")
local start = require("start")

function love.load(arg)
    start.game()
end

function love.update(dt)
    update.all()
end

function love.draw()
    display.all()
end