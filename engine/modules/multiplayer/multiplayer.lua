local enet = require "enet"
local json = require "engine/libs/json"
local funcs = require "engine/core/funcs"
local player = require("engine/modules/player/player")
local data = require("engine/core/data")
local commands = require("engine/modules/multiplayer/commands")
local planets = require("engine/modules/worlds/planets")
local players = require("engine/modules/multiplayer/players")
local server_config = require("server_config")

local multiplayer = {}

local thread0_out = nil
local thread1_out = nil
local thread2_out = nil -- Ввод консоли

local update_timer = love.timer.getTime()
local update_map_timer = love.timer.getTime()
local update_players_area_timer = love.timer.getTime()
local update_blocks_timer = love.timer.getTime() -- таймер обновления отдельных изменённых блоков
local first_package_timer = love.timer.getTime() -- таймер ожидания первого пакета
local player_send_timer = love.timer.getTime() -- таймер отправки информации об игроке

function multiplayer.start()
    thread = love.thread.newThread("engine/modules/multiplayer/" .. data.multiplayer.enet_type .. ".lua")
    thread:start() -- Мультиплеер
    if data.multiplayer.enet_type == "host" then
        thread2 = love.thread.newThread("engine/modules/multiplayer/console.lua")
        thread2:start() -- Ввод консоли
        thread2_out = love.thread.getChannel('thread2_out')
    end

    -- каналы для мультиплеерного потока
    thread0_out = love.thread.getChannel('thread0_out')
    thread1_out = love.thread.getChannel('thread1_out')

    if data.multiplayer.enet_type == "host" then
        thread0_out:push(json.encode({ip=data.multiplayer.ip, port=data.multiplayer.port, map=planets}))
    else 
        thread0_out:push(json.encode({ip=data.multiplayer.ip, port=data.multiplayer.port, nickname=data.settings.nickname}))
    end

    player = funcs.create_message(player, nil, "Мультиплеер запущен.", os.clock(), 255, 255, 0)
    multiplayer_is_loaded = false
    map_size = nil
    first_package_timer = love.timer.getTime()
end

function multiplayer.stop()
    thread0_out:clear()
    thread1_out:clear()
    thread0_out:release()
    thread1_out:release()
    thread:release()
    if data.multiplayer.enet_type == "host" then
        thread2_out:clear()
        thread2_out:release()
        thread2:release()
    end
    player = funcs.create_message(player, nil, "Мультиплеер остановлен.", os.clock(), 255, 255, 0)
    multiplayer_is_loaded = false
    data.multiplayer.world_load_status = 0
    data.multiplayer.enet_type = nil
end

function multiplayer.message_send(message)
    if thread0_out ~= nil then
        thread0_out:push(json.encode({type="message", message=message}))
    end
end

function multiplayer.block_send(x, y)
    if thread0_out ~= nil then
        thread0_out:push(json.encode({type="block", x=x, y=y, block=planets.pcore.map[x][y]}))
    end
end

function multiplayer.console_update()
    if data.multiplayer.enet_type == "host" then
        if thread2_out ~= nil then
            local thread_data = thread2_out:pop()
            if thread_data then
                local command_in_list = false

                local start, _ = string.find(thread_data, " ")
                
                if start ~= nil then
                    search_command = string.sub(thread_data, 1, start - 1)
                    arguments = string.sub(thread_data, start + 1, -1)

                    for _, command in pairs(commands.list) do
                        if search_command == command then
                            command_in_list = true
                        end
                    end

                    if command_in_list == true then
                        result = commands[search_command](arguments)
                        if result ~= nil then
                            multiplayer.message_send({author="server", text=result})
                        end
                    else
                        print("Комманда " .. search_command .. " не найдена.")
                    end
                end
            end
        end
    end
end

function multiplayer.update()
    if update_timer + 0.1 < love.timer.getTime() then
        if thread1_out ~= nil then
            local thread_data = thread1_out:pop()
            while thread_data ~= nil do

                local net_event = json.decode(thread_data)
                if net_event.type == "message" then
                    player = funcs.create_message(player, net_event.message.author, net_event.message.text, os.clock(), 255, 255, 255)
                elseif net_event.type == "map" then
                    planets[net_event.planet].map[net_event.x] = net_event.map
                    if multiplayer_is_loaded == false and net_event.x == map_size then
                        multiplayer_is_loaded = true
                        data.scene = "game"
                    end

                    if multiplayer_is_loaded == false then
                        data.multiplayer.world_load_status = math.floor(net_event.x / map_size * 100)
                    end

                elseif net_event.type == "block" then
                    planets.pcore.map[net_event.x][net_event.y] = net_event.block

                elseif net_event.type == "player" then
                    if net_event.action == "connected" and data.settings.nickname ~= net_event.nickname then
                        players.new[net_event.nickname] = net_event.player
                        players.old[net_event.nickname] = net_event.player
                        players.pseudo[net_event.nickname] = net_event.player
                    elseif net_event.action == "disconnected" then
                        players.new[net_event.nickname] = nil
                        players.old[net_event.nickname] = nil
                        players.pseudo[net_event.nickname] = nil
                    elseif net_event.action == "move" and data.settings.nickname ~= net_event.nickname then
                        -- if players.pseudo[net_event.nickname] == nil then
                        --     players.pseudo[net_event.nickname] = net_event.player
                        -- end
                        players.old[net_event.nickname] = players.pseudo[net_event.nickname]
                        players.new[net_event.nickname] = net_event.player
                    end

                elseif net_event.type == "server_info" then
                    player.x = net_event.spawn_x
                    player.y = net_event.spawn_y
                    player = funcs.create_message(player, "server", net_event.hello_message, os.clock(), 255, 255, 255)
                    map_size = net_event.map_size
                    server_config.spawn_x = net_event.spawn_x
                    server_config.spawn_y = net_event.spawn_y
                end

                thread_data = thread1_out:pop()
            end
        end

        multiplayer.console_update()

        if data.multiplayer.enet_type == "client" and multiplayer_is_loaded == true and player_send_timer + 0.5 < love.timer.getTime() then
            thread0_out:push(json.encode({type="player", action="move", nickname=data.settings.nickname, player={x=player.x, y=player.y, color=data.settings.player_color, orientation=player.orientation}}))
            player_send_timer = love.timer.getTime()
        end

        if data.multiplayer.enet_type == "host" then
            -- for i = x, x + 4 do
            --     thread0_out:push(json.encode({type="map", map=planets.pcore.map[i], planet="pcore", x=i}))
            -- end
            -- if x + 5 < planets.pcore.w then
            --     x = x + 5
            -- else
            --     x = 1
            -- end
            if server_config.update_area > 0 then
                if update_players_area_timer + server_config.update_area_time < love.timer.getTime() then
                    local blocks_for_update = {}
                    for i = 1, planets.pcore.w do
                        table.insert(blocks_for_update, false)
                    end

                    for nickname, player_data in pairs(players.new) do
                        for i = math.floor(player_data.x) - server_config.update_area, math.floor(player_data.x) + server_config.update_area do
                            local coord = funcs.player_x_loop(i, planets.pcore.w)
                            blocks_for_update[coord] = true
                        end
                    end

                    for i = 1, planets.pcore.w do
                        if blocks_for_update[i] == true then
                            thread0_out:push(json.encode({type="map", map=planets.pcore.map[i], planet="pcore", x=i}))
                        end
                    end
                    blocks_for_update = nil
                    update_players_area_timer = love.timer.getTime()
                end
            end

            if server_config.update_blocks_time > 0 then
                if update_blocks_timer + server_config.update_blocks_time < love.timer.getTime() then
                    for i, coords in ipairs(data.multiplayer.blocks_changes) do
                        thread0_out:push(json.encode({type="block", x=coords.x, y=coords.y, block=planets.pcore.map[coords.x][coords.y]}))
                    end
                    data.multiplayer.blocks_changes = {}
                    update_blocks_timer = love.timer.getTime()
                end
            end
        end
        
        update_timer = love.timer.getTime()

        if data.multiplayer.enet_type == "client" and multiplayer_is_loaded == false and map_size == nil and first_package_timer + 10 < love.timer.getTime() then
            multiplayer.stop()
            data.scene = "multiplayer_error"
        end
    end
end

return multiplayer