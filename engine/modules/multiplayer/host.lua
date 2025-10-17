local enet = require "enet"
local json = require "engine/libs/json"

-- get thread channels
local thread0_out = love.thread.getChannel('thread0_out')
local thread1_out = love.thread.getChannel('thread1_out')

local data = nil
while data == nil do
    data = thread0_out:pop()
end

data = json.decode(data)

local host = enet.host_create(data.ip .. ":" .. data.port)
local peers = {}

while true do
    local event = host:service()
    local data = thread0_out:pop()

    while event do
        if event.type == "receive" then
            local net_event = json.decode(event.data)
            if net_event.type == "message" then
                thread1_out:push(net_event)
                host:broadcast(net_event)
            elseif net_event.type == "connect" then
                new_net_event = json.encode({type="message", message={author=nil, text=net_event.player .. " подключился"}})
                thread1_out:push(new_net_event)
                host:broadcast(new_net_event)
            end
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