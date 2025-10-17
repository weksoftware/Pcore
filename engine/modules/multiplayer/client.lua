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

local host = enet.host_create()
local server = host:connect(data.ip .. ":" .. data.port)

while true do
    local event = host:service()
    local data = thread0_out:pop()

    while event do
        if event.type == "receive" then
            local event_data_decode = json.decode(event.data)
            local message = {body=event_data_decode.body, type=event_data_decode.type}
            thread1_out:push(json.encode(message))
        end
    
        event = host:service()
    end
    if data then
        server:send(data)
    end
end