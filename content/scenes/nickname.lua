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
            {type="text", x="center", y="center", size=12, text="Смена никнейма", r=255, g=255, b=255, a=255}
        }
    },
    {
        x=0,
        y=10,
        w=100,
        h=10,
        objects={
            {type="rect", x=0, y=0, w=100, h=100, r=0, g=0, b=0, a=120},
            {type="text", x="center", y="center", size=8, text="Никнейм...", r=255, g=255, b=255, a=255}
        },
        button="nickname_text"
    },
    {
        x=0,
        y=20,
        w=100,
        h=15,
        objects={
            {type="rect", x=0, y=0, w=100, h=100, r=0, g=0, b=0, a=170},
            {type="text", x="center", y="center", size=10, text="Сменить", r=255, g=255, b=255, a=255}
        },
        button="nickname_set"
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
        button="multiplayer"
    }
}

return scene