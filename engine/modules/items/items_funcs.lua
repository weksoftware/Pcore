local data = require("engine/core/data")
local planets = require("engine/modules/worlds/planets")
local items = require("engine/modules/items/items")
local player = require("engine/modules/player/player")
local blocks = require("engine/modules/worlds/blocks")
local multiplayer = require("engine/modules/multiplayer/multiplayer")

local items_funcs = {}

local pickaxe_timer = love.timer.getTime()

function items_funcs.simple_build(item)
    if data.mouse.x ~= nil and data.mouse.button ~= nil then
        local mouse_x = data.mouse.x
        local mouse_y = data.mouse.y
        local x = math.floor((mouse_x / (24 * player.camera.zoom)) + (player.camera.x / 24)) % planets[data.planet].w + 1
        local y = math.floor((mouse_y / (24 * player.camera.zoom)) + (player.camera.y / 24)) % planets[data.planet].h + 1
        local item_used = false
        
        if data.mouse.button == 1 then
            if planets[data.planet].map[x][y].block == "air" or blocks[planets[data.planet].map[x][y].block].physics_type == "powder" then
                planets[data.planet].map[x][y].block = items[item.name].block
                item_used = true
            end
        else
            planets[data.planet].map[x][y].background = items[item.name].block
            item_used = true
        end

        if item_used == true then
            multiplayer.block_send(x, y)
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
        local x = math.floor((mouse_x / (24 * player.camera.zoom)) + (player.camera.x / 24)) % planets[data.planet].w + 1
        local y = math.floor((mouse_y / (24 * player.camera.zoom)) + (player.camera.y / 24)) % planets[data.planet].h + 1
        if planets[data.planet].map[x][y].fire ~= true and blocks[planets[data.planet].map[x][y].block].flammability ~= nil then
            planets[data.planet].map[x][y].fire = true
            multiplayer.block_send(x, y)
            item.count = item.count - 1
            if item.count < 1 then
                return nil
            end
        end
    end
    return item
end

function items_funcs.pickaxe(item)
    if data.mouse.button == 1 and pickaxe_timer < love.timer.getTime()  then
        local mouse_x = data.mouse.x
        local mouse_y = data.mouse.y
        local x = math.floor((mouse_x / (24 * player.camera.zoom)) + (player.camera.x / 24)) % planets[data.planet].w + 1
        local y = math.floor((mouse_y / (24 * player.camera.zoom)) + (player.camera.y / 24)) % planets[data.planet].h + 1
        local physics_type = blocks[planets[data.planet].map[x][y].block].physics_type
        if physics_type == "powder" or physics_type == "solid" then
            local destruction_factor =  blocks[planets[data.planet].map[x][y].block].strength
            planets[data.planet].map[x][y].destruction = planets[data.planet].map[x][y].destruction + items[item.name].pickaxe_speed / destruction_factor
            if planets[data.planet].map[x][y].destruction >= 100 then
                planets[data.planet].map[x][y].destruction = 0
                planets[data.planet].map[x][y].block = "air"
            end
            multiplayer.block_send(x, y)
        end
        pickaxe_timer = love.timer.getTime() + 0.2
    end
    return item
end

return items_funcs