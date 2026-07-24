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
            {type="text", x="center", y="center", size=12, text="Подключение к сетевой игре", r=255, g=255, b=255, a=255}
        }
    },
    {
        x=0,
        y=10,
        w=100,
        h=10,
        objects={
            {type="rect", x=0, y=0, w=100, h=100, r=0, g=0, b=0, a=120},
            {type="text", x="center", y="center", size=8, text="Айпи адрес...", r=255, g=255, b=255, a=255}
        },
        button="multiplayer_ip"
    },
    {
        x=0,
        y=20,
        w=100,
        h=15,
        objects={
            {type="rect", x=0, y=0, w=100, h=100, r=0, g=0, b=0, a=170},
            {type="text", x="center", y="center", size=10, text="Подключиться", r=255, g=255, b=255, a=255}
        },
        button="multiplayer_connect"
    },
    {
        x=0,
        y=75,
        w=50,
        h=15,
        objects={
            {type="rect", x=0, y=0, w=100, h=100, r=0, g=0, b=0, a=120},
            {type="text", x="center", y="center", size=10, text="player", r=255, g=255, b=255, a=255}
        },
        button="multiplayer_nickname"
    },
    {
        x=50,
        y=75,
        w=50,
        h=15,
        objects={
            {type="rect", x=0, y=0, w=100, h=100, r=0, g=0, b=0, a=190},
            {type="text", x="center", y="center", size=10, text="Сменить никнейм", r=255, g=255, b=255, a=255}
        },
        button="nickname"
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