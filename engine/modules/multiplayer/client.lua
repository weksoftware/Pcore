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

function service_protect_code()
    event = host:service()
end

function service_protect()
    local success, error = pcall(service_protect_code)
    if success then
        
    else
        thread1_out:push(json.encode({type="message", message={author=nil, text="Error: " .. error}}))
        if type(event) == "table" then
            print(">>")
            for key, value in pairs(event) do
                print(key)
                if key == "peer" then
                    print(event.peer)
                elseif key == "type" then
                    print(event.type)
                elseif key == "data" then
                    print(event.data)
                end
            end
            print("<<")
        else
            print(">>" ..  type(event) .. "<<")
        end
        event = nil
    end
end

while true do
    service_protect()
    
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
            elseif event_data_decode.type == "items" then
                thread1_out:push(event.data)
            end
        elseif event.type == "connect" then
            server:send(json.encode({type="connect", player=nickname}))
        end
    
        service_protect()
    end
    if data then
        server:send(data)
    end
end