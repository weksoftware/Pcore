local scene = {}

scene.display_game = true
scene.func = "game_update"
scene.windows = {
    {
        x=0,
        y=0,
        w=5,
        h=5,
        objects={
            {type="imageX", sprite="inventory1", x=0, y=0, w=100},
            {not_display=true, type="imageX", sprite="", x=10, y=10, w=80},
            {type="text", x=1, y=0, size=6, text="0", r=255, g=255, b=255, a=255}
        },
        button="inventory_update",
        id=1
    },
    {
        x=5,
        y=0,
        w=5,
        h=5,
        objects={
            {type="imageX", sprite="inventory1", x=0, y=0, w=100},
            {not_display=true, type="imageX", sprite="", x=10, y=10, w=80},
            {type="text", x=1, y=0, size=6, text="0", r=255, g=255, b=255, a=255}
        },
        button="inventory_update",
        id=2
    },
    {
        x=10,
        y=0,
        w=5,
        h=5,
        objects={
            {type="imageX", sprite="inventory1", x=0, y=0, w=100},
            {not_display=true, type="imageX", sprite="", x=10, y=10, w=80},
            {type="text", x=1, y=0, size=6, text="0", r=255, g=255, b=255, a=255}
        },
        button="inventory_update",
        id=3
    },
    {
        x=15,
        y=0,
        w=5,
        h=5,
        objects={
            {type="imageX", sprite="inventory1", x=0, y=0, w=100},
            {not_display=true, type="imageX", sprite="", x=10, y=10, w=80},
            {type="text", x=1, y=0, size=6, text="0", r=255, g=255, b=255, a=255}
        },
        button="inventory_update",
        id=4
    },
    {
        x=20,
        y=0,
        w=5,
        h=5,
        objects={
            {type="imageX", sprite="inventory1", x=0, y=0, w=100},
            {not_display=true, type="imageX", sprite="", x=10, y=10, w=80},
            {type="text", x=1, y=0, size=6, text="0", r=255, g=255, b=255, a=255}
        },
        button="inventory_update",
        id=5
    },
    {
        x=25,
        y=0,
        w=25,
        h=5,
        objects={
            {type="rect", x=0, y=0, w=100, h=100, r=30, g=30, b=30, a=220},
            {type="text", x="center", y=0, size=8, text="item_name", r=255, g=255, b=255, a=255}
        },
        button="item_name_inventory_update"
    }
}

return scene