local display = require("engine/main/display")
local controls = require("engine/main/controls")
local multiplayer_config = require("engine/multiplayer/config")

local d = {}
d.players = require("engine/data/players")

local ms = require("nonengine/libs/multishare")

function love.load()
    update_thread = love.thread.newThread("engine/update/thread.lua")
    update_thread:start()
    love.window.setMode(800, 600, {resizable=true, vsync=false})
    love.window.setTitle("Pcore M")

    d.players = {name=multiplayer_config.name, color=multiplayer_config.color}
    ms.set("players", d.players, "multiplayer")
end

function love.update(dt)
end

function love.draw()
    display.display()
end