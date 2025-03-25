local data = require("level_three/data")
local funcs = require("level_two/funcs")
local map = require("level_two/map")
local planets = require("level_three/planets")

local gui_funcs = {}

local saves_timer = love.timer.getTime()

function gui_funcs.saves_update(scene)
    if saves_timer + 1 < love.timer.getTime() then
        scene = {}
        scene.display_game = true
        scene.func = gui_funcs.saves_update
        scene.windows = {}
        local files = love.filesystem.getDirectoryItems("saves")

        local load_world = {x=0,y=80,w=25,h=10,
            objects={{type="rect", x=0, y=0, w=100, h=100, r=10, g=10, b=10, a=255},{type="text", x="center", y="center", size=8, text="Загрузить", r=255, g=255, b=255, a=255}},
            button=gui_funcs.world_load
        }
        local delete_world = {x=25,y=80,w=25,h=10,
            objects={{type="rect", x=0, y=0, w=100, h=100, r=40, g=0, b=0, a=255},{type="text", x="center", y="center", size=8, text="Удалить", r=255, g=255, b=255, a=255}},
            button=gui_funcs.world_delete
        }
        local create_world = {x=50,y=80,w=50,h=10,
            objects={{type="rect", x=0, y=0, w=100, h=100, r=10, g=10, b=10, a=255},{type="text", x="center", y="center", size=8, text="Создать новый", r=255, g=255, b=255, a=255}},
            button=gui_funcs.new_world
        }
        local back = {x=0,y=90,w=100,h=10,
            objects={{type="rect", x=0, y=0, w=100, h=100, r=0, g=0, b=0, a=255},{type="text", x="center", y="center", size=12, text="Назад", r=255, g=255, b=255, a=255}},
            button=gui_funcs.menu
        }
        local saves = {x=0,y=0,w=100,h=10,
            objects={{type="rect", x=0, y=0, w=100, h=100, r=0, g=0, b=0, a=255},{type="text", x="center", y="center", size=12, text="Сохранения", r=255, g=255, b=255, a=255}}
        }

        local windows = {}

        for i, file in ipairs(files) do
            local file_info = love.filesystem.getInfo("saves/" .. file)
            local window = {
                x=0,
                y=10 + (i - 1) * 15,
                w=100,
                h=15,
                objects={
                    {type="rect", x=0, y=0, w=100, h=100, r=0, g=0, b=0, a=170},
                    {type="text", x=20, y=10, size=8, text=string.sub(file, 1, #file - 5), r=255, g=255, b=255, a=255},
                    {type="text", x=20, y=40, size=8, text=math.floor(file_info.size/1024/1024) .. 'MB', r=125, g=125, b=125, a=255},
                    {type="text", x=20, y=70, size=8, text='Запускался ' .. os.date("%d.%m.%Y", file_info.modtime), r=125, g=125, b=125, a=255}
                },
                scroll=true,
                id=file,
                button=gui_funcs.world_select
            }
            windows[file_info.modtime] = window
        end

        local keys = {}

        for i, window in pairs(windows) do keys[#keys+1] = i end

        table.sort(keys, funcs.reverse_sort)

        for i, key in pairs(keys) do
            scene.windows[#scene.windows + 1] = windows[key] 
            scene.windows[#scene.windows].y = 10 + (i - 1) * 15
        end

        scene.windows[#scene.windows + 1] = load_world
        scene.windows[#scene.windows + 1] = delete_world
        scene.windows[#scene.windows + 1] = create_world
        scene.windows[#scene.windows + 1] = back
        scene.windows[#scene.windows + 1] = saves
    end
    return scene
end

function gui_funcs.play(window, mouse)
    if mouse == true then
        data.scene = "saves"
        data.scene_scroll.x = 0
        data.scene_scroll.y = 0
    end
    return window
end

function gui_funcs.team(window, mouse)
    if mouse == true then
        data.scene = "team"
    end
    return window
end

function gui_funcs.exit(window, mouse)
    if mouse == true then
        love.event.quit()
    end
    return window
end

function gui_funcs.menu(window, mouse)
    if mouse == true then
        data.scene = "menu"
    end
    return window
end

function gui_funcs.settings(window, mouse)
    if mouse == true then
        data.scene = "settings"
    end
    return window
end

function gui_funcs.settings_update(window, mouse)
    if mouse == true then
        if data.settings[window.id] < #data.settings_values[window.id] then
            data.settings[window.id] = data.settings[window.id] + 1
        else
            data.settings[window.id] = 1
        end
        funcs.update_settings()
        funcs.save_settings()
    else
        window.objects[2].text = window.id .. ': ' .. tostring(data.settings_values[window.id][data.settings[window.id]])
    end
    return window
end

function gui_funcs.world_select(window, mouse)
    if mouse == true then
        data.world_select = window.id
        data.map_name = window.id
    end
    if data.world_select == window.id then
        window.objects[1].r = 20
        window.objects[1].g = 20
        window.objects[1].b = 20
    else
        window.objects[1].r = 0
        window.objects[1].g = 0
        window.objects[1].b = 0
    end
    return window
end

function gui_funcs.world_load(window, mouse)
    if mouse == true then
        if data.world_select ~= nil then
            funcs.load_map(data.world_select)
            data.scene = "game"
        end
    end
    return window
end

function gui_funcs.world_delete(window, mouse)
    if mouse == true then
        if data.world_select ~= nil then
            love.filesystem.remove("saves/" .. data.world_select)
        end
    end
    return window
end

function gui_funcs.new_world(window, mouse)
    if mouse == true then
        data.scene = "new_world"
        data.text_input = ""
    end
    return window
end

function gui_funcs.world_name(window, mouse)
    window.objects[2].text = data.text_input
    return window
end

function gui_funcs.world_create(window, mouse)
    if mouse == true then
        planets[data.planet] = map.generation("mars")
        funcs.save_map(data.text_input .. ".json")
        data.map_name = data.text_input .. ".json"
        gui_funcs.play(window, mouse)
    end
    return window
end

function gui_funcs.update_version(window, mouse)
    window.objects[2].text = "v" .. data.version .. " by weksoftware | github.com/weksoftware/Pcore"
    return window
end

return gui_funcs