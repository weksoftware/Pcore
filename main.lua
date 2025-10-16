local data = require("engine/core/data")
if data.multiplayer.enet_type ~= "host" then
    display = require("engine/core/display")
end
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