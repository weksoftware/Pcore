local funcs = require("level_two/funcs")
local multiplayer = require("multiplayer")
local data = require("level_three/data")
local player = require("level_three/player")
local planets = require("level_three/planets")
local blocks = require("level_three/blocks")

local keyboard = {}

local zoom_timer = love.timer.getTime()
local backspace_timer = love.timer.getTime()
local chat_scroll_timer = love.timer.getTime()
local select_block_timer = love.timer.getTime()
local debug_hide_timer = love.timer.getTime()

local utf8 = require("utf8")

function love.textinput(text)
    if player.chat_status == 'open' and love.system.getOS() ~= "Linux" then
        data.message = data.message .. text
    end
    data.text_input = data.text_input .. text
end

function love.keypressed(key)
    if data.scene == 'game' then
        if key == 'd' then
            player.moving.right = true
        elseif key == 'a' then
            player.moving.left = true
        elseif key == 'w' then
            player.moving.up = true
        elseif key == 's' then
            player.moving.down = true
        elseif key == 'z' then
            funcs.save_map(data.map_name)
        elseif key == 'x' then
            funcs.load_map()
        elseif key == 'q' then
            if data.settings_values.autosave[data.settings.autosave] ~= false then
                funcs.save_map(data.map_name)
            end 
            data.scene = "menu"
        elseif key == 'l' then
            data.planet = 'mars'
        elseif key == 'k' then
            data.planet = 'pcore'
        end
    end
end

function love.keyreleased(key)
    if key == 'd' then
        player.moving.right = false
    elseif key == 'a' then
        player.moving.left = false
    elseif key == 'w' then
        player.moving.up = false
    elseif key == 's' then
        player.moving.down = false
    end
end

function love.wheelmoved(x, y)
    local width, height = love.graphics.getDimensions()
    local scroll_factor_y = height / 1080
    data.scene_scroll.y = data.scene_scroll.y + y * scroll_factor_y
    data.scene_scroll.x = data.scene_scroll.x + x
end

function keyboard.update()

    if love.keyboard.isDown('c') and player.chat_status == 'close' then
        player.chat_status = 'open'
    end

    if love.keyboard.isDown('return') and player.chat_status == 'open' then
        if data.message ~= '' then

            if settings.multiplayer == 'client' then
                --local server_message = multiplayer.client(message)
                --player.chat = server_message
                --player = funcs.create_message(player, server_message, os.clock(), 255, 255, 255)
                multiplayer.client(message)

            else
                data.message = ' ' .. settings.name .. ': ' .. data.message .. ' '
                player = funcs.create_message(player, data.message, os.clock(), 255, 255, 255)
            end

            data.message = ''
        end
        player.chat_status = 'close'
    end

    if love.keyboard.isDown('backspace') and backspace_timer + 0.2 < love.timer.getTime() then
        local byteoffset = utf8.offset(data.text_input, -1)
        if byteoffset then
            data.text_input = string.sub(data.text_input, 1, byteoffset - 1)
            backspace_timer = love.timer.getTime()
        end
    end

    if chat_scroll_timer + 0.2 < love.timer.getTime() and player.chat_status == 'open' and love.keyboard.isDown('up') then
        player.chat_scroll = player.chat_scroll - 1
        chat_scroll_timer = love.timer.getTime()
    end

    if chat_scroll_timer + 0.2 < love.timer.getTime() and player.chat_status == 'open' and love.keyboard.isDown('down') then
        player.chat_scroll = player.chat_scroll + 1
        chat_scroll_timer = love.timer.getTime()
    end

    local mouse_x, mouse_y = love.mouse.getPosition()

    -- if love.mouse.isDown(1) then
    --     if data.coord_for_rect ~= nil then
    --         local mouse_xf = math.floor((mouse_x / (24 * player.camera.zoom)) + (player.x / 24)) % planets[data.planet].w + 1
    --         local mouse_yf = math.floor((mouse_y / (24 * player.camera.zoom)) + (player.y / 24)) % planets[data.planet].h + 1
    --         local x = math.min(mouse_xf, data.coord_for_rect.x)
    --         local y = math.min(mouse_yf, data.coord_for_rect.y)
    --         local w = math.max(mouse_xf, data.coord_for_rect.x) - x
    --         local h = math.max(mouse_yf, data.coord_for_rect.y) - y
    --         for xi = 0, w do
    --             for yi = 0, h do
    --                 planets[data.planet].map[xi + x][yi + y].block = data.blocks_for_building[data.block]
    --                 planets[data.planet].map[xi + x][yi + y].fire = nil
    --             end
    --         end
    --         data.coord_for_rect = nil
    --     else         
    --         if blocks[data.blocks_for_building[data.block]].multiblock == nil then
    --             planets[data.planet].map[math.floor((mouse_x / (24 * player.camera.zoom)) + (player.x / 24)) % planets[data.planet].w + 1][math.floor((mouse_y / (24 * player.camera.zoom)) + (player.y / 24)) % planets[data.planet].h + 1].block = data.blocks_for_building[data.block]
    --         else
    --             local w = blocks[data.blocks_for_building[data.block]].multiblock.w
    --             local h = blocks[data.blocks_for_building[data.block]].multiblock.h
    --             local mouse_xf = math.floor((mouse_x / (24 * player.camera.zoom)) + (player.x / 24)) % planets[data.planet].w + 1
    --             local mouse_yf = math.floor((mouse_y / (24 * player.camera.zoom)) + (player.y / 24)) % planets[data.planet].h + 1
    --             for xi = 0, w - 1 do
    --                 for yi = 0, h - 1 do
    --                     planets[data.planet].map[mouse_xf + xi][mouse_yf + yi].block = data.blocks_for_building[data.block]
    --                     planets[data.planet].map[mouse_xf + xi][mouse_yf + yi].multiblock = {x_in_block = xi, y_in_block = yi, x = mouse_xf, y = mouse_yf}
    --                 end
    --             end
    --         end
    --     end
    -- end
    -- if love.mouse.isDown(2) then
    --     local mouse_xf = math.floor((mouse_x / (24 * player.camera.zoom)) + (player.x / 24)) % planets[data.planet].w + 1
    --     local mouse_yf = math.floor((mouse_y / (24 * player.camera.zoom)) + (player.y / 24)) % planets[data.planet].h + 1
    --     data.coord_for_rect = {x = mouse_xf, y = mouse_yf}
    -- end
    -- if love.mouse.isDown(3) then
    --     planets[data.planet].map[math.floor((mouse_x / (24 * player.camera.zoom)) + (player.x / 24)) % planets[data.planet].w + 1][math.floor((mouse_y / (24 * player.camera.zoom)) + (player.y / 24)) % planets[data.planet].h + 1].background = data.blocks_for_building[data.block]
    -- end
    if love.keyboard.isDown('r') then
        if blocks[planets[data.planet].map[math.floor((mouse_x / (24 * player.camera.zoom)) + (player.x / 24)) % planets[data.planet].w + 1][math.floor((mouse_y / (24 * player.camera.zoom)) + (player.y / 24)) % planets[data.planet].h + 1].block].flammability ~= nil then
            planets[data.planet].map[math.floor((mouse_x / (24 * player.camera.zoom)) + (player.x / 24)) % planets[data.planet].w + 1][math.floor((mouse_y / (24 * player.camera.zoom)) + (player.y / 24)) % planets[data.planet].h + 1].fire = true
        end
    end
    
    if select_block_timer + 0.2 < love.timer.getTime() then
        if love.keyboard.isDown('f') then
            if data.block > 1 then 
                data.block = data.block - 1 
            else 
                data.block = #data.blocks_for_building
            end
        end
        if love.keyboard.isDown('g') then
            if data.block < #data.blocks_for_building then 
                data.block = data.block + 1 
            else 
                data.block = 1
            end
        end
        select_block_timer = love.timer.getTime()
    end

    if debug_hide_timer + 0.2 < love.timer.getTime() and love.keyboard.isDown('h') then
        data.display_debug = not (data.display_debug == true)
        debug_hide_timer = love.timer.getTime()
    end

end

return keyboard