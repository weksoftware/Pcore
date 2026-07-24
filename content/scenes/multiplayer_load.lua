local scene = {}
scene.display_game = true
scene.windows = {
    {
        x=0,
        y=45,
        w=100,
        h=20,
        objects={
            {type="rect", x=0, y=0, w=100, h=50, r=0, g=0, b=0, a=170},
            {type="text", x="center", y=15, size=12, text="Загрузка мира...", r=255, g=255, b=255, a=255},
            {type="rect", x=0, y=50, w=100, h=50, r=0, g=0, b=0, a=200},
            {type="rect", x=0, y=50, w=0, h=50, r=0, g=255, b=80, a=255}
        },
        button="multiplayer_load_status"
    }
}

return scene