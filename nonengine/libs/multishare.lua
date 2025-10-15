-- Multishare library for Pcore
-- (c) Weksoftware 2025
-- https://weksoftware.ru/
-- https://github.com/weksoftware

local json = require("nonengine/libs/json")

local ms = {}

function ms.update(variables, channel_read_name) -- Получаем значения
    channel_read = love.thread.getChannel(channel_read_name)
    if channel_read ~= nil then
        local message = channel_read:pop()
        while message do
            local message_decoded = json.decode(message)
            if message_decoded.sub_name == nil then
                variables[message_decoded.name] = message_decoded.value
            else
                variables[message_decoded.name][message_decoded.sub_name] = message_decoded.value
            end
            message = channel_read:pop()
        end
    end
    return variables
end

function ms.set(var_name, var_value, channel_write_name) -- Отправляем значения
    channel_write = love.thread.getChannel(channel_write_name)
    if channel_write ~= nil then
        local message = {name=var_name, value=var_value}
        local message_encoded = json.encode(message)
        channel_write:push(message_encoded)
    end
end

function ms.set_sub_var(var_name, sub_var_name, var_value, channel_write_name) -- Отправляем значения вложенной таблицы
    channel_write = love.thread.getChannel(channel_write_name)
    if channel_write ~= nil then
        local message = {name=var_name, sub_name=sub_var_name, value=var_value[sub_var_name]}
        local message_encoded = json.encode(message)
        channel_write:push(message_encoded)
    end
end

return ms