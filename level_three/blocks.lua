local tilesets = require("level_three/tilesets")

local blocks = {}

blocks.air = {}
blocks.air.texture = nil
blocks.air.tileset_type = nil
blocks.air.physics_type = "air"
blocks.air.shadow = 1
blocks.air.transparency = 1

blocks.water = {}
blocks.water.texture = "textures/blocks/water1.png"
blocks.water.tileset_type = tilesets[1]
blocks.water.physics_type = "liquid"
blocks.water.shadow = 0.8
blocks.water.transparency = 0.95

blocks.sand = {}
blocks.sand.texture = "textures/blocks/sand1.png"
blocks.sand.tileset_type = tilesets[3]
blocks.sand.physics_type = "powder"
blocks.sand.shadow = 0.7
blocks.sand.transparency = 0.9

blocks.steel = {}
blocks.steel.texture = "textures/blocks/steel1.png"
blocks.steel.tileset_type = tilesets[1]
blocks.steel.physics_type = "solid"
blocks.steel.shadow = 0.6
blocks.steel.transparency = 0.99

blocks.oxygen = {}
blocks.oxygen.texture = "textures/blocks/oxygen1.png"
blocks.oxygen.tileset_type = tilesets[1]
blocks.oxygen.physics_type = "gas"
blocks.oxygen.shadow = 1
blocks.oxygen.transparency = 1

blocks.clay = {}
blocks.clay.texture = "textures/blocks/clay1.png"
blocks.clay.tileset_type = tilesets[1]
blocks.clay.physics_type = "powder"
blocks.clay.shadow = 0.7
blocks.clay.transparency = 0.95

blocks.debug = {}
blocks.debug.texture = "textures/blocks/debug1.png"
blocks.debug.tileset_type = tilesets[1]
blocks.debug.physics_type = "liquid"
blocks.debug.shadow = 1
blocks.debug.transparency = 1
blocks.debug.flammability = 0.95
blocks.debug.combustion_product = 'stone'

blocks.glass = {}
blocks.glass.texture = "textures/blocks/glass1.png"
blocks.glass.tileset_type = tilesets[1]
blocks.glass.physics_type = "solid"
blocks.glass.shadow = 0.85
blocks.glass.transparency = 0.99

blocks.lamp = {}
blocks.lamp.texture = "textures/blocks/lamp1.png"
blocks.lamp.tileset_type = tilesets[2]
blocks.lamp.physics_type = "solid"
blocks.lamp.shadow = 1
blocks.lamp.transparency = 16

blocks.cypress_wood = {}
blocks.cypress_wood.texture = "textures/blocks/cypress_wood1.png"
blocks.cypress_wood.tileset_type = tilesets[1]
blocks.cypress_wood.physics_type = "solid"
blocks.cypress_wood.shadow = 1
blocks.cypress_wood.transparency = 1
blocks.cypress_wood.flammability = 0.95
blocks.cypress_wood.combustion_product = 'water'

blocks.cypress_leaves = {}
blocks.cypress_leaves.texture = "textures/blocks/cypress_leaves1.png"
blocks.cypress_leaves.tileset_type = tilesets[1]
blocks.cypress_leaves.physics_type = "solid"
blocks.cypress_leaves.shadow = 0.8
blocks.cypress_leaves.transparency = 0.99
blocks.cypress_leaves.flammability = 0.9
blocks.cypress_leaves.combustion_product = 'carbon_dioxide'

blocks.cypress_cone = {}
blocks.cypress_cone.texture = "textures/blocks/cypress_cone1.png"
blocks.cypress_cone.tileset_type = tilesets[2]
blocks.cypress_cone.physics_type = "powder"
blocks.cypress_cone.shadow = 1
blocks.cypress_cone.transparency = 0.99

blocks.dirt = {}
blocks.dirt.texture = "textures/blocks/dirt1.png"
blocks.dirt.tileset_type = tilesets[1]
blocks.dirt.physics_type = "powder"
blocks.dirt.shadow = 0.5
blocks.dirt.transparency = 0.95

blocks.grass = {}
blocks.grass.texture = "textures/blocks/grass1.png"
blocks.grass.tileset_type = tilesets[1]
blocks.grass.physics_type = "powder"
blocks.grass.shadow = 0.7
blocks.grass.transparency = 0.999

blocks.stone = {}
blocks.stone.texture = "textures/blocks/stone1.png"
blocks.stone.tileset_type = tilesets[1]
blocks.stone.physics_type = "solid"
blocks.stone.shadow = 0.2
blocks.stone.transparency = 0.92

blocks.cable = {}
blocks.cable.texture = "textures/blocks/cable1.png"
blocks.cable.tileset_type = tilesets[1]
blocks.cable.physics_type = "solid"
blocks.cable.shadow = 0.8
blocks.cable.transparency = 1

blocks.carbon_dioxide = {}
blocks.carbon_dioxide.texture = "textures/blocks/carbon_dioxide1.png"
blocks.carbon_dioxide.tileset_type = tilesets[1]
blocks.carbon_dioxide.physics_type = "liquid"
blocks.carbon_dioxide.shadow = 0.95
blocks.carbon_dioxide.transparency = 1

blocks.methane = {}
blocks.methane.texture = "textures/blocks/methane1.png"
blocks.methane.tileset_type = tilesets[1]
blocks.methane.physics_type = "gas"
blocks.methane.shadow = 1
blocks.methane.transparency = 1
blocks.methane.flammability = 0.95

return blocks