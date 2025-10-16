local enet = require "enet"
local json = require "engine/libs/json"
local funcs = require "engine/core/funcs"
local player = require("engine/modules/player/player")
local data = require("engine/core/data")

local multiplayer = {}

local thread0_out = nil
local thread1_out = nil

local update_timer = love.timer.getTime()

function multiplayer.start()
    thread = love.thread.newThread("engine/modules/multiplayer/" .. data.multiplayer.enet_type .. ".lua")
    thread:start()
    -- get thread channels
    thread0_out = love.thread.getChannel('thread0_out')
    thread1_out = love.thread.getChannel('thread1_out')
    player = funcs.create_message(player, nil, "Мультиплеер запущен.", os.clock(), 255, 255, 0)
end

function multiplayer.message_send(message)
    if thread0_out ~= nil then
        thread0_out:push(json.encode(message))
    end
end

function multiplayer.update()
    if update_timer + 0.1 < love.timer.getTime() then
        if thread1_out ~= nil then
            local thread_data = thread1_out:pop()
            if thread_data then
                local message = json.decode(thread_data)
                if message.type == "receive" then
                    player = funcs.create_message(player, message.body.author, message.body.text, os.clock(), 255, 255, 255)
                elseif message.type == "connect" then
                    --player = funcs.create_message(player, nil, message.body.author .. " подключился.", os.clock(), 255, 255, 0)
                elseif message.type == "disconnect" then
                    --player = funcs.create_message(player, nil, message.body.author .. " отключился.", os.clock(), 255, 255, 0)
                end
            end
        end
        update_timer = love.timer.getTime()
    end
end

return multiplayer