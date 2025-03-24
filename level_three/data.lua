local data = {}

data.message = ""
data.settings = {shader = nil, name = 'mrwek', multiplayer = false}
data.planet = "pcore"
data.block = 1
data.blocks_for_building = {"air", "water", "sand", "steel", "clay", "debug", "glass", "lamp", "cypress_wood", "cypress_leaves", "cypress_cone", "dirt", "grass", "stone", "cable", "oxygen", "solar_panel", "electric_furnance", "cypress_planks", "martian_regolith"}
data.display_debug = true
data.coord_for_rect = nil
data.version = "0.0.1.0"
data.scene = "menu"
data.scene_scroll = {x=0, y=0}
data.mouse = {x=nil, y=nil}
data.settings = {vsync=1, display_debug=1, language=1}
data.settings_values = {vsync={true, false}, display_debug={true, false}, language={'ru', 'en'}}
data.world_select = nil
data.text_input = ""
data.map_name = "1.json"

return data