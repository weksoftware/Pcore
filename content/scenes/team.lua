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
        button="menu"
    }
}

return scene