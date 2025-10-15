local ms = require("nonengine/libs/multishare")

local d = {}
d.player = require("engine/data/player")

local controls = {}

function love.keypressed(key, scancode, isrepeat)
    d = ms.update(d, "player")
    if key == "w" then
        d.player.move.y = -0.5
        ms.set_sub_var("player", "move", d.player, "controls")
    elseif key == "s" then
        d.player.move.y = 0.5
        ms.set_sub_var("player", "move", d.player, "controls")
    elseif key == "a" then
        d.player.move.x = -0.5
        ms.set_sub_var("player", "move", d.player, "controls")
    elseif key == "d" then
        d.player.move.x = 0.5
        ms.set_sub_var("player", "move", d.player, "controls")
    end
end

function love.keyreleased(key, scancode)
    if key == "w" then
        d = ms.update(d, "player")
        d.player.move.y = 0
        ms.set_sub_var("player", "move", d.player, "controls")
    elseif key == "s" then
        d = ms.update(d, "player")
        d.player.move.y = 0
        ms.set_sub_var("player", "move", d.player, "controls")
    elseif key == "a" then
        d = ms.update(d, "player")
        d.player.move.x = 0
        ms.set_sub_var("player", "move", d.player, "controls")
    elseif key == "d" then
        d = ms.update(d, "player")
        d.player.move.x = 0
        ms.set_sub_var("player", "move", d.player, "controls")
    end
end

return controls