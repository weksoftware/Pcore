local blocks = require("blocks")
local funcs = require("funcs")
local player = require("player")
local shaders = require("shaders")

local display = {}

local sky1 = love.graphics.newImage("textures/sky1.png")
local sputnik1 = funcs.img_load("textures/sputnik2.png")
local font1 = love.graphics.newFont("fonts/basis33/regular.ttf", 48)
local cursor = funcs.img_load("textures/cursor.png")

local fps = 0
local fps_display = 0
local fps_timer = os.time()

function display.fps()
    if os.time() > fps_timer then
        fps_display = fps
        fps = 0
        fps_timer = os.time()
    else
        fps = fps + 1
    end
    love.graphics.print('FPS ' .. fps_display, font1, 40, 40)
end

function display.chat(message)
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

        if message ~= '' then
            w = font1:getWidth(message .. '  ')
        end

        love.graphics.setColor(0, 0, 0, 0.5)
        love.graphics.rectangle("fill", 0, 950, w, 48)
        love.graphics.setColor(1, 1, 1)

        if message ~= '' then
            local cursor = ''
            if os.time() % 2 == 1 then
                cursor = '|'
            end
            love.graphics.print(' ' .. message .. cursor, font1, 0, 950)
        else
            love.graphics.setColor(0.7, 0.7, 0.7)
            love.graphics.print(' Введите сообщение...', font1, 0, 950)
            love.graphics.setColor(1, 1, 1)
        end
    end
end


function display.all(settings, planet, message)

    love.graphics.draw(sky1, 0, 0, nil, 3)

    love.graphics.draw(sputnik1, 200, 100, nil, 3)

    for xi = 0, math.ceil(20 / player.camera.zoom) do
        for yi = 0, math.ceil(12 / player.camera.zoom) do
            local x = math.floor(xi + player.x / 96) % planet.w + 1
            local y = math.floor(yi + player.y / 96) % planet.h + 1
            texture = blocks[planet.map[x][y].block].texture
            texture1 = blocks[planet.map[x][y].background].texture
            light = planet.map[x][y].light / 256
            if texture1 ~= nil then
                texture1 = texture1[funcs.select_background_img(planet.map, x, y, planet.h, planet.w)]

                love.graphics.setColor(0.85, 0.85, 0.85)
                love.graphics.draw(texture1, ((xi) * 96 - player.x % 96) * player.camera.zoom, ((yi) * 96 - player.y % 96) * player.camera.zoom, nil, 3 * player.camera.zoom)
                love.graphics.setColor(1, 1, 1)
            end
            if texture ~= nil then

                if settings.shader == "light" then
                    love.graphics.setShader(shaders.light)
                    shaders.light:send("light", light)

                    shaders.light:send("light_top", planet.map[x][funcs.coordy(y - 1, planet.h, planet.w)].light / 256)
                    shaders.light:send("light_left", planet.map[funcs.coordx(x - 1, planet.h, planet.w)][y].light / 256)
                    shaders.light:send("light_right", planet.map[funcs.coordx(x + 1, planet.h, planet.w)][y].light / 256)
                    shaders.light:send("light_bottom", planet.map[x][funcs.coordy(y + 1, planet.h, planet.w)].light / 256)

                    shaders.light:send("light_top_left", planet.map[funcs.coordx(x - 1, planet.h, planet.w)][funcs.coordy(y - 1, planet.h, planet.w)].light / 256)
                    shaders.light:send("light_top_right", planet.map[funcs.coordx(x + 1, planet.h, planet.w)][funcs.coordy(y - 1, planet.h, planet.w)].light / 256)
                    shaders.light:send("light_bottom_left", planet.map[funcs.coordx(x - 1, planet.h, planet.w)][funcs.coordy(y + 1, planet.h, planet.w)].light / 256)
                    shaders.light:send("light_bottom_right", planet.map[funcs.coordx(x + 1, planet.h, planet.w)][funcs.coordy(y + 1, planet.h, planet.w)].light / 256)
                end
                
                texture = texture[funcs.select_block_img(planet.map, x, y, planet.h, planet.w)]

                --love.graphics.setColor(light, light, light)
                love.graphics.draw(texture, ((xi) * 96 - player.x % 96) * player.camera.zoom, ((yi) * 96 - player.y % 96) * player.camera.zoom, nil, 3 * player.camera.zoom)
                love.graphics.setColor(1, 1, 1)

                love.graphics.setShader()

                --love.graphics.print(planet.map[x][y].pressure, font1, (xi) * 96 - player.x % 96, (yi) * 96 - player.y % 96)
            end
        end
    end

    display.chat(message)
    display.fps()

    love.graphics.print('x: ' .. math.floor(player.x / 96) .. ' / y: ' .. math.floor(player.y / 96), font1, 40, 80)
    love.graphics.print(planet.ticks .. ' ticks', font1, 40, 120)
    love.graphics.print(player.camera.zoom .. ' zoom', font1, 40, 160)

    local mx, my = love.mouse.getPosition()
    love.graphics.draw(cursor, mx - 14, my - 14, nil, 2)
end

return display