local enet = require "enet"
local json = require "engine/libs/json"
local server_config = require("server_config")
local timer = require("love.timer")

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

local peers_for_world_send = {}
local world_send_timer = timer.getTime()

function world_send()
    for peer_str, data in pairs(peers_for_world_send) do
        for x = data.part * 100 + 1, data.part * 100 + 100 do
            if x <= map.w then
                local new_net_event = json.encode({type="map", map=map.map[x], planet="pcore", x=x})
                data.peer:send(new_net_event)
                if x % 100 == 0 then
                    print("Отправлено " .. x .. " блоков для " .. peer_str)
                end
            end
        end
        peers_for_world_send[peer_str].part = data.part + 1
        if data.part * 100 + 1 > map.w then
            peers_for_world_send[peer_str] = nil
            local new_net_event = json.encode({type="message", message={author=nil, text=peers[peer_str] .. " подключился"}})
            host:broadcast(new_net_event)
            thread1_out:push(new_net_event)

            new_net_event = json.encode({
                type="player", 
                action="connected", 
                nickname=peers[peer_str], 
                player={x=server_config.spawn_x, y=server_config.spawn_y, color=1, orientation="down"}})
            host:broadcast(new_net_event)
            thread1_out:push(new_net_event)
        end
    end
end

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

                new_net_event = json.encode({
                    type="server_info", 
                    hello_message=server_config.hello_message, 
                    spawn_x=server_config.spawn_x,
                    spawn_y=server_config.spawn_y,
                    map_size=map.w
                })
                event.peer:send(new_net_event)

                peers[tostring(event.peer)] = net_event.player
                peers_for_world_send[tostring(event.peer)] = {part=0, peer=event.peer}

            elseif net_event.type == "player" then
                host:broadcast(event.data)
                thread1_out:push(event.data)
            elseif net_event.type == "block" then
                thread1_out:push(event.data)
                host:broadcast(event.data)
                map.map[net_event.x][net_event.y] = net_event.block
            end
            
        elseif event.type == "disconnect" then
            local new_net_event = json.encode({type="message", message={author=nil, text=peers[tostring(event.peer)] .. " отключился"}})
            host:broadcast(new_net_event)
            thread1_out:push(new_net_event)

            new_net_event = json.encode({type="player", action="disconnected", nickname=peers[tostring(event.peer)]})
            host:broadcast(new_net_event)
            thread1_out:push(new_net_event)

            peers[tostring(event.peer)] = nil
            peers_for_world_send[tostring(event.peer)] = nil
        end
        event = host:service()
    end

    if data then
        if data ~= "users" then
            local net_event = json.decode(data)
            if net_event.type == "map" then
                map.map[net_event.x] = net_event.map
                host:broadcast(data, 0, "unreliable")
            else
                host:broadcast(data)
            end
        else
            thread1_out:push(json.encode({type="users", list=users}))
        end
    end

    if world_send_timer + 1 < love.timer.getTime() then
        world_send()
        world_send_timer = timer.getTime()
    end
end