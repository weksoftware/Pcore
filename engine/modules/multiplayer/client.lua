local enet = require "enet"
local json = require "engine/libs/json"

-- get thread channels
local thread0_out = love.thread.getChannel('thread0_out')
local thread1_out = love.thread.getChannel('thread1_out')

local data = nil
while data == nil or (type(data) == "string" and json.decode(data).port) == nil do
    data = thread0_out:pop()
end

data = json.decode(data)

local nickname = data.nickname

local host = enet.host_create()
print(data.ip)
local server = host:connect(data.ip .. ":" .. data.port)

while true do
    local event = host:service()
    local data = thread0_out:pop()

    while event do
        if event.type == "receive" then
            local event_data_decode = json.decode(event.data)
            if event_data_decode.type == "message" then
                local net_event = {message=event_data_decode.message, type=event_data_decode.type}
                thread1_out:push(json.encode(net_event))
            elseif event_data_decode.type == "map" then
                thread1_out:push(event.data)
            elseif event_data_decode.type == "block" then
                thread1_out:push(event.data)
            elseif event_data_decode.type == "player" then
                thread1_out:push(event.data)
            elseif event_data_decode.type == "server_info" then
                thread1_out:push(event.data)
            elseif event_data_decode.type == "server_stat" then
                thread1_out:push(event.data)
            end
        elseif event.type == "connect" then
            server:send(json.encode({type="connect", player=nickname}))
        end
    
        event = host:service()
    end
    if data then
        server:send(data)
    end
end