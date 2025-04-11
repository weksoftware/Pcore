local data = require("level_three/data")
local planets = require("level_three/planets")
local items = require("level_two/items")
local player = require("level_three/player")
local blocks = require("level_three/blocks")

local items_funcs = {}

function items_funcs.simple_build(item)
    if data.mouse.x ~= nil and data.mouse.button ~= nil then
        local mouse_x = data.mouse.x
        local mouse_y = data.mouse.y
        local x = math.floor((mouse_x / (24 * player.camera.zoom)) + (player.x / 24)) % planets[data.planet].w + 1
        local y = math.floor((mouse_y / (24 * player.camera.zoom)) + (player.y / 24)) % planets[data.planet].h + 1
        if planets[data.planet].map[x][y].block == "air" then
            planets[data.planet].map[x][y].block = items[item.name].block
            item.count = item.count - 1
            if item.count < 1 then
                return nil
            end
        end
    end
    return item
end

function items_funcs.match(item)
    if data.mouse.button == 1 then
        local mouse_x = data.mouse.x
        local mouse_y = data.mouse.y
        data.mouse.x = nil
        data.mouse.y = nil
        data.mouse.button = nil
        local x = math.floor((mouse_x / (24 * player.camera.zoom)) + (player.x / 24)) % planets[data.planet].w + 1
        local y = math.floor((mouse_y / (24 * player.camera.zoom)) + (player.y / 24)) % planets[data.planet].h + 1
        if planets[data.planet].map[x][y].fire ~= true and blocks[planets[data.planet].map[x][y].block].flammability ~= nil then
            planets[data.planet].map[x][y].fire = true
            item.count = item.count - 1
            if item.count < 1 then
                return nil
            end
        end
    end
    return item
end

function items_funcs.pickaxe(item)
    if data.mouse.x ~= nil then
        local mouse_x = data.mouse.x
        local mouse_y = data.mouse.y
        data.mouse.x = nil
        data.mouse.y = nil
        local x = math.floor((mouse_x / (24 * player.camera.zoom)) + (player.x / 24)) % planets[data.planet].w + 1
        local y = math.floor((mouse_y / (24 * player.camera.zoom)) + (player.y / 24)) % planets[data.planet].h + 1
        local physics_type = blocks[planets[data.planet].map[x][y].block].physics_type
        if physics_type == "powder" or physics_type == "solid" then
            planets[data.planet].map[x][y].block = "air"
        end
    end
    return item
end

return items_funcs