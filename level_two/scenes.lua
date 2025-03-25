local gui_funcs = require("level_two/gui_funcs")

local scenes = {}

scenes.menu = {}
scenes.menu.display_game = true
scenes.menu.windows = {
    {
        x=0,
        y=5,
        w=100,
        h=20,
        objects={
            {type="text", x="center", y="center", size=40, text="Pcore", r=255, g=255, b=255, a=255}
        }
    },
    {
        x=25,
        y=25,
        w=50,
        h=10,
        objects={
            {type="rect", x=0, y=0, w=100, h=100, r=0, g=0, b=0, a=120},
            {type="text", x="center", y="center", size=12, text="Играть", r=255, g=255, b=255, a=255}
        },
        button=gui_funcs.play
    },
    {
        x=25,
        y=35,
        w=50,
        h=10,
        objects={
            {type="rect", x=0, y=0, w=100, h=100, r=0, g=0, b=0, a=170},
            {type="text", x="center", y="center", size=12, text="Настройки", r=255, g=255, b=255, a=255}
        },
        button=gui_funcs.settings
    },
    {
        x=25,
        y=45,
        w=50,
        h=10,
        objects={
            {type="rect", x=0, y=0, w=100, h=100, r=0, g=0, b=0, a=120},
            {type="text", x="center", y="center", size=12, text="Наша команда", r=255, g=255, b=255, a=255}
        },
        button=gui_funcs.team
    },
    {
        x=25,
        y=55,
        w=50,
        h=10,
        objects={
            {type="rect", x=0, y=0, w=100, h=100, r=0, g=0, b=0, a=170},
            {type="text", x="center", y="center", size=12, text="Выход", r=255, g=255, b=255, a=255}
        },
        button=gui_funcs.exit
    },
    {
        x=0,
        y=95,
        w=100,
        h=5,
        objects={
            {type="rect", x=0, y=0, w=100, h=100, r=0, g=0, b=0, a=170},
            {type="text", x=1, y=0, size=10, text="v0.0.0.3 by weksoftware | github.com/weksoftware/Pcore", r=255, g=255, b=255, a=255}
        },
        button=gui_funcs.update_version
    }
}

scenes.game = {}
scenes.game.display_game = true
scenes.game.windows = {}

scenes.team = {}
scenes.team.display_game = true
scenes.team.windows = {
    {
        x=0,
        y=0,
        w=100,
        h=10,
        objects={
            {type="rect", x=0, y=0, w=100, h=100, r=0, g=0, b=0, a=170},
            {type="text", x="center", y="center", size=12, text="В разработке игры участвовали:", r=255, g=255, b=255, a=255}
        }
    },
    {
        x=0,
        y=10,
        w=100,
        h=80,
        objects={
            {type="rect", x=0, y=0, w=100, h=100, r=0, g=0, b=0, a=120},
            {type="text", x="center", y=0, size=8, text="mrwek (программист, дизайнер текстур)", r=255, g=255, b=255, a=255},
            {type="text", x="center", y=40, size=10, text="Наши спонсоры:", r=255, g=255, b=255, a=255},
            {type="text", x="center", y=45, size=8, text="-----", r=255, g=255, b=255, a=255},
            {type="text", x="center", y=85, size=10, text="Особая благодарность:", r=255, g=255, b=255, a=255},
            {type="text", x="center", y=92, size=8, text="denis (команда weksoftware)", r=255, g=255, b=255, a=255}
        }
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
        button=gui_funcs.menu
    }
}

scenes.settings = {}
scenes.settings.display_game = true
scenes.settings.windows = {
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
        button=gui_funcs.settings_update
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
        button=gui_funcs.settings_update
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
        button=gui_funcs.settings_update
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
        button=gui_funcs.settings_update
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
        button=gui_funcs.settings_update
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
        button=gui_funcs.menu
    }
}

scenes.saves = {}
scenes.saves.display_game = true
scenes.saves.func = gui_funcs.saves_update
scenes.saves.windows = {}

scenes.new_world = {}
scenes.new_world.display_game = true
scenes.new_world.windows = {
    {
        x=0,
        y=0,
        w=100,
        h=10,
        objects={
            {type="rect", x=0, y=0, w=100, h=100, r=0, g=0, b=0, a=170},
            {type="text", x="center", y="center", size=12, text="Создание мира", r=255, g=255, b=255, a=255}
        }
    },
    {
        x=0,
        y=10,
        w=100,
        h=10,
        objects={
            {type="rect", x=0, y=0, w=100, h=100, r=0, g=0, b=0, a=120},
            {type="text", x="center", y="center", size=8, text="Название мира...", r=255, g=255, b=255, a=255}
        },
        button=gui_funcs.world_name
    },
    {
        x=0,
        y=20,
        w=100,
        h=15,
        objects={
            {type="rect", x=0, y=0, w=100, h=100, r=0, g=0, b=0, a=170},
            {type="text", x="center", y="center", size=10, text="Создать", r=255, g=255, b=255, a=255}
        },
        button=gui_funcs.world_create
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
        button=gui_funcs.play
    }
}

return scenes