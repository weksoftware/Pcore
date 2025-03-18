local blocks = require("level_three/blocks")
local funcs = require("level_two/funcs")
local player = require("level_three/player")
local shaders = require("level_three/shaders")
local data = require("level_three/data")
local planets = require("level_three/planets")
local gui = require("level_two/gui")
local chat = require("level_two/chat")

local display = {}

local sky1 = love.graphics.newImage("textures/sky1.png")
local sputnik1 = funcs.img_load("textures/sputnik2.png")
local font1 = love.graphics.newFont("fonts/basis33/regular.ttf", 48)
local fire1 = funcs.fire_img_load("textures/fire1.png")

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
    if data.display_debug == true then
        love.graphics.print('FPS ' .. fps_display, font1, 40, 40)
    end
end

function display.blocks()
    local width, height = love.graphics.getDimensions()
    for xi = 0, math.ceil(width / 24 / player.camera.zoom) do
        for yi = 0, math.ceil(height / 24 / player.camera.zoom) do
            local x = math.floor(xi + player.x / 24) % planets[data.planet].w + 1
            local y = math.floor(yi + player.y / 24) % planets[data.planet].h + 1
            local texture = blocks[planets[data.planet].map[x][y].block].texture
            local fire = planets[data.planet].map[x][y].fire
            local texture1 = blocks[planets[data.planet].map[x][y].background].texture
            local light = planets[data.planet].map[x][y].light / 256
            if texture1 ~= nil and (blocks[planets[data.planet].map[x][y].block].background_display ~= nil or funcs.is_not_full_block(planets[data.planet].map[x][y].img_num) == true) then
                texture1 = texture1[funcs.select_background_img(planets[data.planet].map, x, y, planets[data.planet].h, planets[data.planet].w)]
                love.graphics.setColor(0.85 * light, 0.85 * light, 0.85 * light)
                love.graphics.draw(texture1, ((xi) * 24 - player.x % 24) * player.camera.zoom, ((yi) * 24 - player.y % 24) * player.camera.zoom, nil, 3 * player.camera.zoom)
                love.graphics.setColor(1, 1, 1)
            end
            if texture ~= nil then
                texture = texture[planets[data.planet].map[x][y].img_num]
                love.graphics.setColor(light, light, light)
                love.graphics.draw(texture, ((xi) * 24 - player.x % 24) * player.camera.zoom, ((yi) * 24 - player.y % 24) * player.camera.zoom, nil, 3 * player.camera.zoom)
                love.graphics.setColor(1, 1, 1)
            end
            if fire ~= nil then
                love.graphics.draw(fire1[math.floor((planets[data.planet].ticks/1)%4)], ((xi) * 24 - player.x % 24) * player.camera.zoom, ((yi) * 24 - player.y % 24) * player.camera.zoom, nil, 3 * player.camera.zoom)
            end
                
        end
    end
end

function display.all()
    local width, height = love.graphics.getDimensions()
    love.graphics.draw(sky1, 0, 0, nil, width / 640, height / 360)
    display.blocks()
    chat.display()
    display.fps()
    gui.display()
end

return display