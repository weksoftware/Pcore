local enet = require "enet"
local json = require "engine/libs/json"
local funcs = require "engine/core/funcs"
local player = require("engine/modules/player/player")
local data = require("engine/core/data")
local commands = require("engine/modules/multiplayer/commands")

local multiplayer = {}

local thread0_out = nil
local thread1_out = nil
local thread2_out = nil -- Ввод консоли

local update_timer = love.timer.getTime()

function multiplayer.start()
    thread = love.thread.newThread("engine/modules/multiplayer/" .. data.multiplayer.enet_type .. ".lua")
    thread2 = love.thread.newThread("engine/modules/multiplayer/console.lua")
    thread:start() -- Мультиплеер
    thread2:start() -- Ввод консоли

    -- get thread channels
    thread0_out = love.thread.getChannel('thread0_out')
    thread1_out = love.thread.getChannel('thread1_out')
    thread2_out = love.thread.getChannel('thread2_out')
    player = funcs.create_message(player, nil, "Мультиплеер запущен.", os.clock(), 255, 255, 0)
end

function multiplayer.message_send(message)
    if thread0_out ~= nil then
        thread0_out:push(json.encode(message))
    end
end

function multiplayer.console_update()
    if thread2_out ~= nil then
        local thread_data = thread2_out:pop()
        if thread_data then
            local command_in_list = false

            local start, _ = string.find(thread_data, " ")
            
            if start ~= nil then
                search_command = string.sub(thread_data, 1, start - 1)
                arguments = string.sub(thread_data, start + 1, -1)

                for _, command in pairs(commands.list) do
                    if search_command == command then
                        command_in_list = true
                    end
                end

                if command_in_list == true then
                    result = commands[search_command](arguments)
                    if result ~= nil then
                        multiplayer.message_send({type="receive", body={author="server", text=result}})
                    end
                else
                    print("Комманда " .. search_command .. " не найдена.")
                end
            end
        end
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

        multiplayer.console_update()
        
        update_timer = love.timer.getTime()
    end
end

return multiplayer