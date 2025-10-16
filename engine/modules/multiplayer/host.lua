local enet = require "enet"
local json = require "engine/libs/json"
local data = require("engine/core/data")

-- get thread channels
local thread0_out = love.thread.getChannel('thread0_out')
local thread1_out = love.thread.getChannel('thread1_out')

local host = enet.host_create(data.multiplayer.ip .. ":" .. data.multiplayer.port)
local peers = {}

while true do
    local event = host:service()
    local data = thread0_out:pop()

    while event do
        if event.type == "receive" then
            local event_data_decode = json.decode(event.data)
            local message = json.encode({type="receive", body=event_data_decode})
            thread1_out:push(message)
            host:broadcast(message)
            -- for key, val in pairs(peers) do
            --     if key ~= tostring(event.peer) then
            --         local peer = host:get_peer(val)
            --         peer:send(message)
            --     end
            -- end
        elseif event.type == "connect" then
            peers[tostring(event.peer)] = event.peer:index()
            local message = json.encode({type="connect", body=event_data_decode})

            thread1_out:push(message)
        elseif event.type == "disconnect" then
            peers[tostring(event.peer)] = nil
            local message = json.encode({type="disconnect", body=event_data_decode})

            thread1_out:push(message)
        end
        event = host:service()
    end
    if data then
        if data ~= "users" then
            host:broadcast(data)
        else
            thread1_out:push(json.encode({type="users", list=users}))
        end
    end
end