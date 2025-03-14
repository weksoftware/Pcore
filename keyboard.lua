local keyboard = {}
local funcs = require("funcs")
local multiplayer = require("multiplayer")
local utf8 = require("utf8")

local zoom_timer = os.clock()
local backspace_timer = os.clock()
local chat_scroll_timer = os.clock()

function keyboard.update(player, planet, message)

    if player.chat_status == 'close' and love.keyboard.isDown('q') then
        os.exit()
    end

    if love.keyboard.isDown('d') then
        if player.x + 10 < planet.w * 96 then
            player.x = player.x + math.floor(10 / player.camera.zoom)
        else
            player.x = 0
        end
    end

    if love.keyboard.isDown('a') then
        if player.x - 10 > 0 then
            player.x = player.x - math.floor(10 / player.camera.zoom)
        else
            player.x = planet.w * 96 - 10
        end
    end
    if love.keyboard.isDown('s') then
        player.y = player.y + math.floor(10 / player.camera.zoom)
    end
    if love.keyboard.isDown('w') then
        player.y = player.y - math.floor(10 / player.camera.zoom)
    end


    if love.keyboard.isDown('l') and zoom_timer + 0.1 <= os.clock() then
        player.camera.zoom = player.camera.zoom + 0.05
        zoom_timer = os.clock()
    end
    if love.keyboard.isDown('k') and zoom_timer + 0.1 <= os.clock() and player.camera.zoom - 0.05 >= 0 then
        player.camera.zoom = player.camera.zoom - 0.05
        zoom_timer = os.clock()
    end

    if love.keyboard.isDown('c') and player.chat_status == 'close' then
        player.chat_status = 'open'
    end

    if love.keyboard.isDown('return') and player.chat_status == 'open' then
        if message ~= '' then

            if settings.multiplayer == 'client' then
                --local server_message = multiplayer.client(message)
                --player.chat = server_message
                --player = funcs.create_message(player, server_message, os.clock(), 255, 255, 255)
                multiplayer.client(message)

            else
                message = ' ' .. settings.name .. ': ' .. message .. ' '
                player = funcs.create_message(player, message, os.clock(), 255, 255, 255)
            end

            message = ''
        end
        player.chat_status = 'close'
    end

    if love.keyboard.isDown('backspace') and player.chat_status == 'open' and backspace_timer + 0.2 < os.clock() then
        local byteoffset = utf8.offset(message, -1)
        if byteoffset then
            message = string.sub(message, 1, byteoffset - 1)
            backspace_timer = os.clock()
        end
    end

    if chat_scroll_timer + 0.1 < os.clock() and player.chat_status == 'open' and love.keyboard.isDown('up') then
        player.chat_scroll = player.chat_scroll - 1
        chat_scroll_timer = os.clock()
    end

    if chat_scroll_timer + 0.1 < os.clock() and player.chat_status == 'open' and love.keyboard.isDown('down') then
        player.chat_scroll = player.chat_scroll + 1
        chat_scroll_timer = os.clock()
    end

    local mouse_x, mouse_y = love.mouse.getPosition()

    if love.mouse.isDown(1) then
        planet.map[math.floor((mouse_x / (96 * player.camera.zoom)) + (player.x / 96)) % planet.w + 1][math.floor((mouse_y / (96 * player.camera.zoom)) + (player.y / 96)) % planet.h + 1].block = "steel"
    end
    if love.mouse.isDown(2) then
        planet.map[math.floor((mouse_x / (96 * player.camera.zoom)) + (player.x / 96)) % planet.w + 1][math.floor((mouse_y / (96 * player.camera.zoom)) + (player.y / 96)) % planet.h + 1].background = "steel"
    end
    if love.mouse.isDown(3) then
        planet.map[math.floor((mouse_x / (96 * player.camera.zoom)) + (player.x / 96)) % planet.w + 1][math.floor((mouse_y / (96 * player.camera.zoom)) + (player.y / 96)) % planet.h + 1].block = "air"
    end
    if love.keyboard.isDown('f') then
        planet.map[math.floor((mouse_x / (96 * player.camera.zoom)) + (player.x / 96)) % planet.w + 1][math.floor((mouse_y / (96 * player.camera.zoom)) + (player.y / 96)) % planet.h + 1].block = "cypress_cone"
    end
    if love.keyboard.isDown('g') then
        planet.map[math.floor((mouse_x / (96 * player.camera.zoom)) + (player.x / 96)) % planet.w + 1][math.floor((mouse_y / (96 * player.camera.zoom)) + (player.y / 96)) % planet.h + 1].block = "cypress_leaves"
    end
    if love.keyboard.isDown('o') then
        planet.map[math.floor((mouse_x / (96 * player.camera.zoom)) + (player.x / 96)) % planet.w + 1][math.floor((mouse_y / (96 * player.camera.zoom)) + (player.y / 96)) % planet.h + 1].background = "cypress_leaves"
    end
    if love.keyboard.isDown('h') then
        planet.map[math.floor((mouse_x / (96 * player.camera.zoom)) + (player.x / 96)) % planet.w + 1][math.floor((mouse_y / (96 * player.camera.zoom)) + (player.y / 96)) % planet.h + 1].background = "cypress_wood"
    end
    

    return player, planet, message

end

return keyboard