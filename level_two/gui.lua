local player = require("level_three/player")
local data = require("level_three/data")
local planets = require("level_three/planets")
local scenes = require("level_two/scenes")
local funcs = require("level_two/funcs")
local fonts = require("level_three/fonts")

local gui = {}

local cursor = funcs.img_load("textures/cursor.png")
local font1 = love.graphics.newFont("fonts/basis33/regular.ttf", 48)

local fps = 0
local fps_display = 0
local fps_timer = os.time()

function gui.fps()
    if os.time() > fps_timer then
        fps_display = fps
        fps = 0
        fps_timer = os.time()
    else
        fps = fps + 1
    end
    love.graphics.print('FPS ' .. fps_display, font1, 40, 40)
end

function gui.display()
    local width, height = love.graphics.getDimensions()
    local w_percento = width / 100
    local h_percento = height / 100

    if data.display_debug == true then
        gui.fps()
        love.graphics.print('x: ' .. math.floor(player.x / 24) .. ' / y: ' .. math.floor(player.y / 24), font1, 40, 80)
        love.graphics.print(planets[data.planet].ticks .. ' ticks', font1, 40, 120)
        love.graphics.print(player.camera.zoom .. ' zoom', font1, 40, 160)
        love.graphics.print('block: ' .. data.blocks_for_building[data.block], font1, 40, 200)
        love.graphics.print('version ' .. data.version, font1, 40, 240)
        love.graphics.print('scene: ' .. data.scene, font1, 40, 280)
    end

    for key_win, window in ipairs(scenes[data.scene].windows) do
        local window_x = window.x * w_percento
        local window_y = window.y * h_percento
        local window_w = window.w * w_percento
        local window_h = window.h * h_percento

        if window.scroll ~= nil then
            window_y = window_y - data.scene_scroll.y * 30
        end

        for key_obj, object in ipairs(window.objects) do
            local object_x, object_y = nil

            if object.type == "rect" then
                object_x = window_x + window_w / 100 * object.x
                object_y = window_y + window_h / 100 * object.y
                love.graphics.setColor(object.r / 255, object.g / 255, object.b / 255, object.a / 255)
                love.graphics.rectangle("fill", object_x, object_y, window_w / 100 * object.w, window_h / 100 * object.h)
                love.graphics.setColor(1, 1, 1)
            elseif object.type == "text" then
                if object.x ~= "center" then
                    object_x = window_x + window_w / 100 * object.x
                else
                    object_x = window_x + window_w / 100 * 50 - fonts.list[object.size]:getWidth(object.text) / 2
                end
                if object.y ~= "center" then
                    object_y = window_y + window_h / 100 * object.y
                else
                    object_y = window_y + window_h / 100 * 50 - fonts.list[object.size]:getHeight(object.text) / 2
                end
                love.graphics.setColor(object.r / 255, object.g / 255, object.b / 255, object.a / 255)
                love.graphics.print(object.text, fonts.list[object.size], object_x, object_y)
                love.graphics.setColor(1, 1, 1)
            end
        end
    end

    local mx, my = love.mouse.getPosition()
    love.graphics.draw(cursor, mx - 14, my - 14, nil, 2)
end

function gui.update()
    local width, height = love.graphics.getDimensions()
    local w_percento = width / 100
    local h_percento = height / 100
    
    if scenes[data.scene].func ~= nil then
        scenes[data.scene] = scenes[data.scene].func(scenes[data.scene])
    end

    for key_win, window in ipairs(scenes[data.scene].windows) do
        local window_x = window.x * w_percento
        local window_y = window.y * h_percento
        local window_w = window.w * w_percento
        local window_h = window.h * h_percento

        if window.scroll ~= nil then
            window_y = window_y - data.scene_scroll.y * 20
        end

        local mouse = false
        if data.mouse.x ~= nil and data.mouse.x > window_x and data.mouse.x < window_x + window_w and data.mouse.y > window_y and data.mouse.y < window_y + window_h then
            mouse = true
            data.mouse.x = nil
            data.mouse.y = nil
        end
        if window.button ~= nil then
            window = window.button(window, mouse)
        end
    end
end

return gui