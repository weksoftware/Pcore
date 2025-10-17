local server_config = require("server_config")
local data = require("engine/core/data")
data.multiplayer.enet_type = server_config.enet_type
data.multiplayer.port = server_config.port
data.multiplayer.ip = server_config.ip

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