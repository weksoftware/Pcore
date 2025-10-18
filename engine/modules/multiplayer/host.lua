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
local map = data.map.pcore -- игровая карта на момент включения сервера

local host = enet.host_create(data.ip .. ":" .. data.port)
local peers = {}

while true do
    local event = host:service()
    local data = thread0_out:pop()

    while event do
        if event.type == "receive" then
            local net_event = json.decode(event.data)

            if net_event.type == "message" then
                thread1_out:push(event.data)
                host:broadcast(event.data)

            elseif net_event.type == "connect" then
                peers[tostring(event.peer)] = net_event.player
                for x = 1, map.w do
                    local new_net_event = json.encode({type="map", map=map.map[x], planet="pcore", x=x})
                    event.peer:send(new_net_event)
                end
                local new_net_event = json.encode({type="message", message={author=nil, text=net_event.player .. " подключился"}})
                host:broadcast(new_net_event)
                thread1_out:push(new_net_event)

                new_net_event = json.encode({type="player", action="connected", nickname=net_event.player, player={x=0, y=0}})
                host:broadcast(new_net_event)

            elseif net_event.type == "player" then
                host:broadcast(event.data)
            elseif net_event.type == "block" then
                host:broadcast(event.data)
                map.map[net_event.x][net_event.y] = net_event.block
            end
            
        elseif event.type == "disconnect" then
            local new_net_event = json.encode({type="message", message={author=nil, text=peers[tostring(event.peer)] .. " отключился"}})
            host:broadcast(new_net_event)
            thread1_out:push(new_net_event)

            new_net_event = json.encode({type="player", action="disconnected", nickname=peers[tostring(event.peer)]})
            host:broadcast(new_net_event)

            peers[tostring(event.peer)] = nil
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