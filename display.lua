local blocks = require("level_three/blocks")
local funcs = require("level_two/funcs")
local player = require("level_three/player")
local shaders = require("level_three/shaders")
local data = require("level_three/data")
local planets = require("level_three/planets")

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

function display.chat()
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

function display.gui()
    love.graphics.print('x: ' .. math.floor(player.x / 96) .. ' / y: ' .. math.floor(player.y / 96), font1, 40, 80)
    love.graphics.print(planets[data.planet].ticks .. ' ticks', font1, 40, 120)
    love.graphics.print(player.camera.zoom .. ' zoom', font1, 40, 160)

    local mx, my = love.mouse.getPosition()
    love.graphics.draw(cursor, mx - 14, my - 14, nil, 2)
end 


function display.all()

    love.graphics.draw(sky1, 0, 0, nil, 3)

    for xi = 0, math.ceil(20 / player.camera.zoom) do
        for yi = 0, math.ceil(12 / player.camera.zoom) do
            local x = math.floor(xi + player.x / 96) % planets[data.planet].w + 1
            local y = math.floor(yi + player.y / 96) % planets[data.planet].h + 1
            texture = blocks[planets[data.planet].map[x][y].block].texture
            texture1 = blocks[planets[data.planet].map[x][y].background].texture
            light = planets[data.planet].map[x][y].light / 256
            if texture1 ~= nil then
                texture1 = texture1[funcs.select_background_img(planets[data.planet].map, x, y, planets[data.planet].h, planets[data.planet].w)]
                love.graphics.setColor(0.85, 0.85, 0.85)
                love.graphics.draw(texture1, ((xi) * 96 - player.x % 96) * player.camera.zoom, ((yi) * 96 - player.y % 96) * player.camera.zoom, nil, 3 * player.camera.zoom)
                love.graphics.setColor(1, 1, 1)
            end
            if texture ~= nil then
                texture = texture[funcs.select_block_img(planets[data.planet].map, x, y, planets[data.planet].h, planets[data.planet].w)]
                love.graphics.draw(texture, ((xi) * 96 - player.x % 96) * player.camera.zoom, ((yi) * 96 - player.y % 96) * player.camera.zoom, nil, 3 * player.camera.zoom)
            end
        end
    end

    display.chat()
    display.fps()
    display.gui()
end

return display