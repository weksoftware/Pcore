local blocks = {}

blocks.tileset1 = {
    {['x'] = 0, ['y'] = 0},
    {['x'] = 1, ['y'] = 0},
    {['x'] = 2, ['y'] = 0},
    {['x'] = 2, ['y'] = 1},
    {['x'] = 2, ['y'] = 2},
    {['x'] = 1, ['y'] = 2},
    {['x'] = 0, ['y'] = 2},
    {['x'] = 0, ['y'] = 1},
    {['x'] = 1, ['y'] = 1},

    {['x'] = 5, ['y'] = 0},
    {['x'] = 6, ['y'] = 1},
    {['x'] = 5, ['y'] = 2},
    {['x'] = 4, ['y'] = 1},

    {['x'] = 1, ['y'] = 4},
    {['x'] = 3, ['y'] = 4},
    {['x'] = 5, ['y'] = 4},

    {['x'] = 1, ['y'] = 5},
    {['x'] = 2, ['y'] = 5},
    {['x'] = 2, ['y'] = 6},
    {['x'] = 1, ['y'] = 6}
}

blocks.tileset2 = {
    {['x'] = 0, ['y'] = 0},
    {['x'] = 0, ['y'] = 0},
    {['x'] = 0, ['y'] = 0},
    {['x'] = 0, ['y'] = 0},
    {['x'] = 0, ['y'] = 0},
    {['x'] = 0, ['y'] = 0},
    {['x'] = 0, ['y'] = 0},
    {['x'] = 0, ['y'] = 0},
    {['x'] = 0, ['y'] = 0},

    {['x'] = 0, ['y'] = 0},
    {['x'] = 0, ['y'] = 0},
    {['x'] = 0, ['y'] = 0},
    {['x'] = 0, ['y'] = 0},

    {['x'] = 0, ['y'] = 0},
    {['x'] = 0, ['y'] = 0},
    {['x'] = 0, ['y'] = 0},

    {['x'] = 0, ['y'] = 0},
    {['x'] = 0, ['y'] = 0},
    {['x'] = 0, ['y'] = 0},
    {['x'] = 0, ['y'] = 0}
}

blocks.tileset3 = {
    {['x'] = 0, ['y'] = 0},
    {['x'] = 1, ['y'] = 0},
    {['x'] = 2, ['y'] = 0},
    {['x'] = 2, ['y'] = 1},
    {['x'] = 2, ['y'] = 2},
    {['x'] = 1, ['y'] = 2},
    {['x'] = 0, ['y'] = 2},
    {['x'] = 0, ['y'] = 1},
    {['x'] = 1, ['y'] = 1},

    {['x'] = 5, ['y'] = 0},
    {['x'] = 6, ['y'] = 1},
    {['x'] = 5, ['y'] = 2},
    {['x'] = 4, ['y'] = 1},

    {['x'] = 1, ['y'] = 4},
    {['x'] = 3, ['y'] = 4},
    {['x'] = 5, ['y'] = 4},

    {['x'] = 0, ['y'] = 0},
    {['x'] = 2, ['y'] = 0},
    {['x'] = 2, ['y'] = 2},
    {['x'] = 0, ['y'] = 2}
}

blocks.air = {}
blocks.air.texture = nil
blocks.air.tileset_type = nil
blocks.air.physics_type = "air"
blocks.air.shadow = 1
blocks.air.transparency = 1

blocks.water = {}
blocks.water.texture = "textures/blocks/water1.png"
blocks.water.tileset_type = blocks.tileset3
blocks.water.physics_type = "liquid"
blocks.water.shadow = 0.8
blocks.water.transparency = 0.95

blocks.sand = {}
blocks.sand.texture = "textures/blocks/sand1.png"
blocks.sand.tileset_type = blocks.tileset3
blocks.sand.physics_type = "powder"
blocks.sand.shadow = 0.7
blocks.sand.transparency = 0.9

blocks.steel = {}
blocks.steel.texture = "textures/blocks/steel1.png"
blocks.steel.tileset_type = blocks.tileset1
blocks.steel.physics_type = "solid"
blocks.steel.shadow = 0.6
blocks.steel.transparency = 0.99

blocks.oxygen = {}
blocks.oxygen.texture = "textures/blocks/oxygen1.png"
blocks.oxygen.tileset_type = blocks.tileset3
blocks.oxygen.physics_type = "gas"
blocks.oxygen.transparency = 1
blocks.oxygen.transparency = 1

blocks.clay = {}
blocks.clay.texture = "textures/blocks/clay1.png"
blocks.clay.tileset_type = blocks.tileset3
blocks.clay.physics_type = "solid"
blocks.clay.shadow = 0.7
blocks.clay.transparency = 0.95

blocks.debug = {}
blocks.debug.texture = "textures/blocks/debug2.png"
blocks.debug.tileset_type = blocks.tileset3
blocks.debug.physics_type = "solid"
blocks.debug.shadow = 1
blocks.debug.transparency = 1

blocks.glass = {}
blocks.glass.texture = "textures/blocks/glass1.png"
blocks.glass.tileset_type = blocks.tileset1
blocks.glass.physics_type = "solid"
blocks.glass.shadow = 0.85
blocks.glass.transparency = 0.99

blocks.lamp = {}
blocks.lamp.texture = "textures/blocks/lamp1.png"
blocks.lamp.tileset_type = blocks.tileset2
blocks.lamp.physics_type = "solid"
blocks.lamp.shadow = 1
blocks.lamp.transparency = 16

blocks.cypress_wood = {}
blocks.cypress_wood.texture = "textures/blocks/cypress_wood1.png"
blocks.cypress_wood.tileset_type = blocks.tileset1
blocks.cypress_wood.physics_type = "solid"
blocks.cypress_wood.shadow = 1
blocks.cypress_wood.transparency = 1

blocks.cypress_leaves = {}
blocks.cypress_leaves.texture = "textures/blocks/cypress_leaves1.png"
blocks.cypress_leaves.tileset_type = blocks.tileset1
blocks.cypress_leaves.physics_type = "solid"
blocks.cypress_leaves.shadow = 0.8
blocks.cypress_leaves.transparency = 0.99

blocks.cypress_cone = {}
blocks.cypress_cone.texture = "textures/blocks/cypress_cone1.png"
blocks.cypress_cone.tileset_type = blocks.tileset2
blocks.cypress_cone.physics_type = "powder"
blocks.cypress_cone.shadow = 1
blocks.cypress_cone.transparency = 0.99

return blocks