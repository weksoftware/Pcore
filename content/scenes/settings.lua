local scene = {}

scene.display_game = true
scene.windows = {
    {
        x=0,
        y=0,
        w=100,
        h=10,
        objects={
            {type="rect", x=0, y=0, w=100, h=100, r=0, g=0, b=0, a=170},
            {type="text", x="center", y="center", size=12, text="Настройки", r=255, g=255, b=255, a=255}
        }
    },
    {
        x=0,
        y=10,
        w=100,
        h=10,
        objects={
            {type="rect", x=0, y=0, w=100, h=100, r=0, g=0, b=0, a=120},
            {type="text", x="center", y="center", size=8, text="vsync", r=255, g=255, b=255, a=255}
        },
        id="vsync",
        button="settings_update"
    },
    {
        x=0,
        y=20,
        w=100,
        h=10,
        objects={
            {type="rect", x=0, y=0, w=100, h=100, r=0, g=0, b=0, a=170},
            {type="text", x="center", y="center", size=8, text="display_debug", r=255, g=255, b=255, a=255}
        },
        id="display_debug",
        button="settings_update"
    },
    {
        x=0,
        y=30,
        w=100,
        h=10,
        objects={
            {type="rect", x=0, y=0, w=100, h=100, r=0, g=0, b=0, a=120},
            {type="text", x="center", y="center", size=8, text="language", r=255, g=255, b=255, a=255}
        },
        id="language",
        button="settings_update"
    },
    {
        x=0,
        y=40,
        w=100,
        h=10,
        objects={
            {type="rect", x=0, y=0, w=100, h=100, r=0, g=0, b=0, a=170},
            {type="text", x="center", y="center", size=8, text="zoom", r=255, g=255, b=255, a=255}
        },
        id="zoom",
        button="settings_update"
    },
    {
        x=0,
        y=50,
        w=100,
        h=10,
        objects={
            {type="rect", x=0, y=0, w=100, h=100, r=0, g=0, b=0, a=120},
            {type="text", x="center", y="center", size=8, text="autosave", r=255, g=255, b=255, a=255}
        },
        id="autosave",
        button="settings_update"
    },
    {
        x=0,
        y=60,
        w=100,
        h=10,
        objects={
            {type="rect", x=0, y=0, w=100, h=100, r=0, g=0, b=0, a=170},
            {type="text", x="center", y="center", size=8, text="player_color", r=255, g=255, b=255, a=255}
        },
        id="player_color",
        button="settings_update_color"
    },
    {
        x=0,
        y=70,
        w=100,
        h=10,
        objects={
            {type="rect", x=0, y=0, w=100, h=100, r=0, g=0, b=0, a=120},
            {type="text", x="center", y="center", size=8, text="shaders", r=255, g=255, b=255, a=255}
        },
        id="shaders",
        button="settings_update"
    },
    {
        x=0,
        y=90,
        w=100,
        h=10,
        objects={
            {type="rect", x=0, y=0, w=100, h=100, r=0, g=0, b=0, a=170},
            {type="text", x="center", y="center", size=12, text="Назад", r=255, g=255, b=255, a=255}
        },
        button="menu"
    }
}

return scene