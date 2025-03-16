local player = require("level_three/player")
local chat = {}

local font1 = love.graphics.newFont("fonts/basis33/regular.ttf", 48)

function chat.display()
    local start_y = 870 - player.chat_size * 48 - player.chat_scroll * 48
    for i = 1, player.chat_size do
        if player.chat[i].time + 5 >= os.clock() or player.chat_status == 'open' then
            if player.chat[i].w == nil then
                player.chat[i].w = font1:getWidth(player.chat[i].text)
            end

            love.graphics.setColor(0, 0, 0, 0.5)
            love.graphics.rectangle("fill", 0, start_y + i * 48, player.chat[i].w, 48)
            love.graphics.setColor(player.chat[i].color.r, player.chat[i].color.g, player.chat[i].color.b)
            love.graphics.print(player.chat[i].text, font1, 0, start_y + i * 48)
            love.graphics.setColor(1, 1, 1)
        end
    end

    if player.chat_status == 'open' then

        local w = font1:getWidth(' Введите сообщение... ')

        if data.message ~= '' then
            w = font1:getWidth(data.message .. '  ')
        end

        love.graphics.setColor(0, 0, 0, 0.5)
        love.graphics.rectangle("fill", 0, 950, w, 48)
        love.graphics.setColor(1, 1, 1)

        if data.message ~= '' then
            local cursor = ''
            if os.time() % 2 == 1 then
                cursor = '|'
            end
            love.graphics.print(' ' .. data.message .. cursor, font1, 0, 950)
        else
            love.graphics.setColor(0.7, 0.7, 0.7)
            love.graphics.print(' Введите сообщение...', font1, 0, 950)
            love.graphics.setColor(1, 1, 1)
        end
    end
end

return chat