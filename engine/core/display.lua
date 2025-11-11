local blocks = require("engine/modules/worlds/blocks")
local funcs = require("engine/core/funcs")
local player = require("engine/modules/player/player")
local shaders = require("engine/modules/graphics/shaders")
local data = require("engine/core/data")
local planets = require("engine/modules/worlds/planets")
local gui = require("engine/modules/graphics/gui/gui")
local chat = require("engine/modules/graphics/chat/chat")
local players = require("engine/modules/multiplayer/players")

local display = {}

local skies = {
    pcore=funcs.img_load("media/textures/skies/pcore.png"), 
    mars=funcs.img_load("media/textures/skies/mars.png")
}
local sputnik1 = funcs.img_load("media/textures/sputnik2.png")
local font1 = love.graphics.newFont("media/fonts/basis33/regular.ttf", 48)
local font2 = love.graphics.newFont("media/fonts/basis33/regular.ttf", 12)
local fire1 = funcs.animation_img_load("media/textures/fire1.png", 4)
local destruction1 = funcs.animation_img_load("media/textures/destruction1.png", 5)
local player1 = funcs.player_img_load("media/textures/player1.png")

function display.blocks()
    local width, height = love.graphics.getDimensions()
    if data.settings_values.shaders[data.settings.shaders] ~= false then
        shaders[data.settings_values.shaders[data.settings.shaders]]:send("is_blocks",1)
    end

    for xi = 0, math.ceil(width / 24 / player.camera.zoom) do
        for yi = 0, math.ceil(height / 24 / player.camera.zoom) do

            local x = math.floor(xi + player.camera.x / 24) % planets[data.planet].w + 1
            local y = math.floor(yi + player.camera.y / 24) % planets[data.planet].h + 1
            local texture = blocks[planets[data.planet].map[x][y].block].texture
            local fire = planets[data.planet].map[x][y].fire
            local destruction = planets[data.planet].map[x][y].destruction
            local texture1 = blocks[planets[data.planet].map[x][y].background].texture
            local light = planets[data.planet].map[x][y].light / 256
            if fire ~= nil then light = 1 end
            
            if y + 1 < planets[data.planet].h then down_light = planets[data.planet].map[x][y + 1].light / 256 else down_light = 0 end-- яркость блока под текущим

            if data.settings_values.shaders[data.settings.shaders] ~= false then
                shaders[data.settings_values.shaders[data.settings.shaders]]:send("light",light)
                if data.settings_values.shaders[data.settings.shaders] == "light" then
                    shaders[data.settings_values.shaders[data.settings.shaders]]:send("down_light",down_light)
                end
            end

            if texture1 ~= nil and (blocks[planets[data.planet].map[x][y].block].background_display ~= nil or funcs.is_not_full_block(planets[data.planet].map[x][y].img_num) == true) then
                texture1 = texture1[funcs.select_background_img(planets[data.planet].map, x, y, planets[data.planet].h, planets[data.planet].w)]
                love.graphics.setColor(0.85, 0.85, 0.85)
                love.graphics.draw(texture1, ((xi) * 24 - player.camera.x % 24) * player.camera.zoom, ((yi) * 24 - player.camera.y % 24) * player.camera.zoom, nil, 3 * player.camera.zoom)
                love.graphics.setColor(1, 1, 1)
            end

            if texture ~= nil then
                texture = texture[planets[data.planet].map[x][y].img_num]
                love.graphics.draw(texture, ((xi) * 24 - player.camera.x % 24) * player.camera.zoom, ((yi) * 24 - player.camera.y % 24) * player.camera.zoom, nil, 3 * player.camera.zoom)
            end

            if destruction > 0 then
                love.graphics.draw(destruction1[math.ceil(destruction / 20)], ((xi) * 24 - player.camera.x % 24) * player.camera.zoom, ((yi) * 24 - player.camera.y % 24) * player.camera.zoom, nil, 3 * player.camera.zoom)
            end

            if fire ~= nil then
                love.graphics.draw(fire1[planets[data.planet].ticks%4+1], ((xi) * 24 - player.camera.x % 24) * player.camera.zoom, ((yi) * 24 - player.camera.y % 24) * player.camera.zoom, nil, 3 * player.camera.zoom)
            end
        end
    end
end

function display.player()
    if data.scene == "game" then
        local orientation = 2
        if player.orientation == "left" then
            orientation = 1
        elseif player.orientation == "right" then
            orientation = 3
        end
        local width, height = love.graphics.getDimensions()
        local color = data.settings_values.player_color[data.settings.player_color]
        local x = width / 2 - 12 * player.camera.zoom
        local y = height / 2 - 24 * player.camera.zoom
        love.graphics.draw(player1[orientation], x, y, nil, 3 * player.camera.zoom)
        love.graphics.setColor(color.r / 255, color.g / 255, color.b / 255)
        love.graphics.draw(player1[3 + orientation], x, y, nil, 3 * player.camera.zoom)
        love.graphics.setColor(1, 1, 1)
        if data.multiplayer.enet_type == "client" then
            for nickname, player_data in pairs(players.pseudo) do
                local orientation = 2
                if players.new[nickname].orientation == "left" then
                    orientation = 1
                elseif players.new[nickname].orientation == "right" then
                    orientation = 3
                end
                local x = (player_data.x * 24 - player.camera.x - 12) * player.camera.zoom
                local y = (player_data.y * 24 - player.camera.y - 24) * player.camera.zoom
                color = data.settings_values.player_color[players.new[nickname].color]
                love.graphics.draw(player1[orientation], x, y, nil, 3 * player.camera.zoom)
                love.graphics.setColor(color.r / 255, color.g / 255, color.b / 255)
                love.graphics.draw(player1[3 + orientation], x, y, nil, 3 * player.camera.zoom)
                love.graphics.setColor(1, 1, 1)
                love.graphics.print(nickname, font1, x - font1:getWidth(nickname) / 2 + 12 * player.camera.zoom, y - 48 * player.camera.zoom)
            end
        end
    end
end

function display.shaders(is_visible)
    if is_visible == true then
        if data.settings_values.shaders[data.settings.shaders] ~= false then
            love.graphics.setShader(shaders[data.settings_values.shaders[data.settings.shaders]])
            if data.settings_values.shaders[data.settings.shaders] == "light" then
            shaders[data.settings_values.shaders[data.settings.shaders]]:send("down_light",1)
            end
            shaders[data.settings_values.shaders[data.settings.shaders]]:send("light",1)
            shaders[data.settings_values.shaders[data.settings.shaders]]:send("is_blocks",0)
        end
    else
        if data.settings_values.shaders[data.settings.shaders] ~= false then
            love.graphics.setShader()
        end
    end
end

function display.all()
    if data.multiplayer.enet_type ~= "host" then
        local width, height = love.graphics.getDimensions()
        
        display.shaders(true)
        love.graphics.draw(skies[data.planet], 0, 0, nil, width / 640, height / 360)
        display.blocks()

        display.shaders(false)
        display.player()

        chat.display()
        gui.display()
    end
end

return display