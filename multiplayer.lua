local multiplayer = {}
local funcs = require("level_two/funcs")
local player = require("level_three/player")
local json = require("level_three/json")

local enet = require "enet"
local host = nil
local server = nil

--local server_funcs = {}

--function server_funcs.new_message()

function multiplayer.connect_to_server(ip)
    host = enet.host_create()
    server = host:connect(ip)
end

function multiplayer.client(message)
    local event = host:service(10)
    local message_from_server = nil
    while event do
        if event.type == "receive" then
            --print("Got message: ", event.data, event.peer)
            message_from_server = event.data
            event.peer:send(message)
        elseif event.type == "connect" then
            event.peer:send('')
            --message_from_server = json.decode(event.data)
        elseif event.type == "disconnect" then
            print(event.peer, "disconnected.")
        end

        event = host:service()
    end
    return message_from_server
end

function multiplayer.server_start(ip)
    host = enet.host_create(ip)
    print('Server is active! (naverno)')
    player = funcs.create_message(player, 'Сервер запущен', os.clock(), 0, 173, 3)
end

function multiplayer.server()
    local event = host:service(10)

    while event do
        local message = ''
        if event.type == "receive" then
            if event.data ~= '' then
                message = tostring(event.peer) .. ': ' .. event.data
            end
            event.peer:send(json.encode(player.chat))

        elseif event.type == "connect" then
            message = 'Player ' .. tostring(event.peer) .. ' connected'
            player = funcs.create_message(player, message, os.clock(), 255, 233, 36)
            message = ''
            print(message)

        elseif event.type == "disconnect" then
            message = 'Player ' .. tostring(event.peer) .. ' disconnected'
            player = funcs.create_message(player, message, os.clock(), 255, 233, 36)
            message = ''
            print(message)
        end

        if message ~= '' then
            player = funcs.create_message(player, message, os.clock(), 255, 255, 255)
            print(message)
        end
        event = host:service()
    end
end

return multiplayer