local data = {}

data.message = ""
data.settings = {shader = nil, name = 'mrwek', multiplayer = false}
data.planet = "pcore"
data.block = 1
data.blocks_for_building = {"air", "water", "sand", "steel", "clay", "debug", "glass", "lamp", "cypress_wood", "cypress_leaves", "cypress_cone", "dirt", "grass", "stone", "cable", "oxygen", "solar_panel", "electric_furnance", "cypress_planks", "martian_regolith", "bricks"}
data.display_debug = true
data.coord_for_rect = nil
data.version = "0.0.2.2"
data.scene = "menu"
data.scene_scroll = {x=0, y=0}
data.mouse = {x=nil, y=nil}
data.settings = {vsync=1, display_debug=2, language=1, zoom=4, autosave=2, player_color=2}
data.settings_values = {
    vsync={true, false}, 
    display_debug={true, false}, 
    language={'ru', 'en'}, 
    zoom={0.5, 0.75, 1, 1.5, 2, 3}, 
    autosave={false, "exit", "5min", "10min", "30min"}, 
    player_color={
        {r=220, g=220, b=220, a=1},
        {r=128, g=128, b=128, a=1},
        {r=50, g=50, b=50, a=1},
        {r=128, g=0, b=128, a=1},
        {r=255, g=0, b=0, a=1},
        {r=128, g=0, b=0, a=1},
        {r=255, g=255, b=0, a=1},
        {r=255, g=128, b=0, a=1},
        {r=100, g=255, b=80, a=1},
        {r=25, g=150, b=0, a=1},
        {r=140, g=240, b=255, a=1},
        {r=60, g=140, b=255, a=1},
        {r=30, g=50, b=180, a=1}
    }
}
data.world_select = nil
data.text_input = ""
data.map_name = "1.json"

return data