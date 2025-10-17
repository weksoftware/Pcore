local json = require "engine/libs/json"

-- get thread channels
local thread2_out = love.thread.getChannel('thread2_out')

while true do
    thread2_out:push(io.read())
end