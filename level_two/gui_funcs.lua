local data = require("level_three/data")
local funcs = require("level_two/funcs")

local gui_funcs = {}

function gui_funcs.play(window, mouse)
    if mouse == true then
        data.scene = "game"
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
        data.settings[window.id] = not data.settings[window.id]
        funcs.update_settings()
        funcs.save_settings()
    else
        window.objects[2].text = window.id .. ': ' .. tostring(data.settings[window.id])
    end
    return window
end


return gui_funcs