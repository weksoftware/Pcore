local ms = require("nonengine/libs/multishare")
love.math = require("love.math")
love.timer = require("love.timer")

local d = {}
d.player = require("engine/data/player")
d.window = require("engine/data/window")
d.map = require("engine/data/map")
d.camera = require("engine/data/camera")

local update_timer = love.timer.getTime()

while true do
    d = ms.update(d, "controls")

    if update_timer + 0.05 < love.timer.getTime() then
        d.player.coords.x = d.player.coords.x + d.player.move.x
        d.player.coords.y = d.player.coords.y + d.player.move.y
        d.camera.coords.x = d.player.coords.x - d.window.sizes.x / 2 - 0.5
        d.camera.coords.y = d.player.coords.y - d.window.sizes.y / 2 - 0.5

        if d.map.map[math.floor(d.player.coords.x)][math.floor(d.player.coords.y)].block == "air" then
            d.map.map[math.floor(d.player.coords.x)][math.floor(d.player.coords.y)].block = "rnd"
            d.map.map[math.floor(d.player.coords.x)][math.floor(d.player.coords.y)].color = love.math.random(256)
        end

        update_timer = love.timer.getTime()
        ms.set_sub_var("player", "coords", d.player, "update")
        ms.set("window", d.window, "update")
        ms.set("map", d.map, "update")
        ms.set("camera", d.camera, "update")
    end
end