local scene = {}

scene.display_game = true
scene.windows = {
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
        button="play"
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
        button="settings"
    },
    {
        x=25,
        y=45,
        w=50,
        h=10,
        objects={
            {type="rect", x=0, y=0, w=100, h=100, r=0, g=0, b=0, a=120},
            {type="text", x="center", y="center", size=12, text="Мультиплеер", r=255, g=255, b=255, a=255}
        },
        button="multiplayer"
    },
    {
        x=25,
        y=55,
        w=50,
        h=10,
        objects={
            {type="rect", x=0, y=0, w=100, h=100, r=0, g=0, b=0, a=170},
            {type="text", x="center", y="center", size=12, text="Наша команда", r=255, g=255, b=255, a=255}
        },
        button="team"
    },
    {
        x=25,
        y=65,
        w=50,
        h=10,
        objects={
            {type="rect", x=0, y=0, w=100, h=100, r=0, g=0, b=0, a=120},
            {type="text", x="center", y="center", size=12, text="Выход", r=255, g=255, b=255, a=255}
        },
        button="exit"
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
        button="update_version"
    }
}

return scene