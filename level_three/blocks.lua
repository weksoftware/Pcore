local tilesets = require("level_three/tilesets")

local blocks = {}

blocks.air = {}
blocks.air.texture = nil
blocks.air.tileset_type = nil
blocks.air.physics_type = "air"
blocks.air.shadow = 1
blocks.air.transparency = 1
blocks.air.background_display = true
blocks.air.strength = 1

blocks.water = {}
blocks.water.texture = "textures/blocks/water1.png"
blocks.water.tileset_type = tilesets[1]
blocks.water.physics_type = "liquid"
blocks.water.shadow = 0.8
blocks.water.transparency = 0.95
blocks.water.background_display = true
blocks.water.strength = 1

blocks.sand = {}
blocks.sand.texture = "textures/blocks/sand1.png"
blocks.sand.tileset_type = tilesets[3]
blocks.sand.physics_type = "powder"
blocks.sand.shadow = 0.7
blocks.sand.transparency = 0.9
blocks.sand.strength = 1

blocks.steel = {}
blocks.steel.texture = "textures/blocks/steel1.png"
blocks.steel.tileset_type = tilesets[1]
blocks.steel.physics_type = "solid"
blocks.steel.shadow = 0.6
blocks.steel.transparency = 0.99
blocks.steel.strength = 10

blocks.oxygen = {}
blocks.oxygen.texture = "textures/blocks/oxygen1.png"
blocks.oxygen.tileset_type = tilesets[1]
blocks.oxygen.physics_type = "gas"
blocks.oxygen.shadow = 1
blocks.oxygen.transparency = 1
blocks.oxygen.background_display = true
blocks.oxygen.strength = 1

blocks.clay = {}
blocks.clay.texture = "textures/blocks/clay1.png"
blocks.clay.tileset_type = tilesets[1]
blocks.clay.physics_type = "powder"
blocks.clay.shadow = 0.7
blocks.clay.transparency = 0.95
blocks.clay.strength = 1

blocks.debug = {}
blocks.debug.texture = "textures/blocks/debug1.png"
blocks.debug.tileset_type = tilesets[1]
blocks.debug.physics_type = "liquid"
blocks.debug.shadow = 1
blocks.debug.transparency = 1
blocks.debug.flammability = 0.95
blocks.debug.combustion_product = 'stone'
blocks.debug.strength = 1

blocks.glass = {}
blocks.glass.texture = "textures/blocks/glass1.png"
blocks.glass.tileset_type = tilesets[1]
blocks.glass.physics_type = "solid"
blocks.glass.shadow = 0.85
blocks.glass.transparency = 0.99
blocks.glass.background_display = true
blocks.glass.strength = 0.5

blocks.lamp = {}
blocks.lamp.texture = "textures/blocks/lamp1.png"
blocks.lamp.tileset_type = tilesets[2]
blocks.lamp.physics_type = "solid"
blocks.lamp.shadow = 1
blocks.lamp.transparency = 16
blocks.lamp.strength = 1

blocks.cypress_wood = {}
blocks.cypress_wood.texture = "textures/blocks/cypress_wood1.png"
blocks.cypress_wood.tileset_type = tilesets[1]
blocks.cypress_wood.physics_type = "solid"
blocks.cypress_wood.shadow = 1
blocks.cypress_wood.transparency = 1
blocks.cypress_wood.flammability = 0.95
blocks.cypress_wood.combustion_product = 'water'
blocks.cypress_wood.strength = 2

blocks.cypress_planks = {}
blocks.cypress_planks.texture = "textures/blocks/cypress_planks1.png"
blocks.cypress_planks.tileset_type = tilesets[1]
blocks.cypress_planks.physics_type = "solid"
blocks.cypress_planks.shadow = 0.85
blocks.cypress_planks.transparency = 0.98
blocks.cypress_planks.flammability = 0.95
blocks.cypress_planks.combustion_product = 'carbon_dioxide'
blocks.cypress_planks.strength = 1.5

blocks.cypress_leaves = {}
blocks.cypress_leaves.texture = "textures/blocks/cypress_leaves1.png"
blocks.cypress_leaves.tileset_type = tilesets[1]
blocks.cypress_leaves.physics_type = "solid"
blocks.cypress_leaves.shadow = 0.8
blocks.cypress_leaves.transparency = 0.99
blocks.cypress_leaves.flammability = 0.9
blocks.cypress_leaves.combustion_product = 'carbon_dioxide'
blocks.cypress_leaves.strength = 0.5

blocks.cypress_cone = {}
blocks.cypress_cone.texture = "textures/blocks/cypress_cone1.png"
blocks.cypress_cone.tileset_type = tilesets[2]
blocks.cypress_cone.physics_type = "powder"
blocks.cypress_cone.shadow = 1
blocks.cypress_cone.transparency = 0.99
blocks.cypress_cone.background_display = true
blocks.cypress_cone.strength = 1

blocks.dirt = {}
blocks.dirt.texture = "textures/blocks/dirt1.png"
blocks.dirt.tileset_type = tilesets[1]
blocks.dirt.physics_type = "powder"
blocks.dirt.shadow = 0.5
blocks.dirt.transparency = 0.95
blocks.dirt.strength = 1

blocks.grass = {}
blocks.grass.texture = "textures/blocks/grass1.png"
blocks.grass.tileset_type = tilesets[1]
blocks.grass.physics_type = "powder"
blocks.grass.shadow = 0.7
blocks.grass.transparency = 0.999
blocks.grass.strength = 0.5

blocks.stone = {}
blocks.stone.texture = "textures/blocks/stone1.png"
blocks.stone.tileset_type = tilesets[1]
blocks.stone.physics_type = "solid"
blocks.stone.shadow = 0.5
blocks.stone.transparency = 0.92
blocks.stone.strength = 3

blocks.cable = {}
blocks.cable.texture = "textures/blocks/cable1.png"
blocks.cable.tileset_type = tilesets[1]
blocks.cable.physics_type = "solid"
blocks.cable.shadow = 0.8
blocks.cable.transparency = 1
blocks.cable.background_display = true
blocks.cable.strength = 0.5

blocks.carbon_dioxide = {}
blocks.carbon_dioxide.texture = "textures/blocks/carbon_dioxide1.png"
blocks.carbon_dioxide.tileset_type = tilesets[1]
blocks.carbon_dioxide.physics_type = "liquid"
blocks.carbon_dioxide.shadow = 0.95
blocks.carbon_dioxide.transparency = 1
blocks.carbon_dioxide.background_display = true
blocks.carbon_dioxide.strength = 1

blocks.methane = {}
blocks.methane.texture = "textures/blocks/methane1.png"
blocks.methane.tileset_type = tilesets[1]
blocks.methane.physics_type = "gas"
blocks.methane.shadow = 1
blocks.methane.transparency = 1
blocks.methane.flammability = 0.95
blocks.methane.background_display = true
blocks.methane.strength = 1

blocks.solar_panel = {}
blocks.solar_panel.texture = "textures/blocks/solar_panel1.png"
blocks.solar_panel.physics_type = "solid"
blocks.solar_panel.shadow = 0.8
blocks.solar_panel.transparency = 1
blocks.solar_panel.multiblock = {w = 4, h = 1}
blocks.solar_panel.strength = 1

blocks.electric_furnance = {}
blocks.electric_furnance.texture = "textures/blocks/electric_furnance1.png"
blocks.electric_furnance.physics_type = "solid"
blocks.electric_furnance.shadow = 0.8
blocks.electric_furnance.transparency = 1
blocks.electric_furnance.multiblock = {w = 3, h = 2}
blocks.electric_furnance.strength = 1

blocks.martian_regolith = {}
blocks.martian_regolith.texture = "textures/blocks/martian_regolith1.png"
blocks.martian_regolith.tileset_type = tilesets[1]
blocks.martian_regolith.physics_type = "powder"
blocks.martian_regolith.shadow = 0.8
blocks.martian_regolith.transparency = 0.98
blocks.martian_regolith.strength = 2

blocks.martian_dense_regolith = {}
blocks.martian_dense_regolith.texture = "textures/blocks/martian_dense_regolith1.png"
blocks.martian_dense_regolith.tileset_type = tilesets[1]
blocks.martian_dense_regolith.physics_type = "powder"
blocks.martian_dense_regolith.shadow = 0.7
blocks.martian_dense_regolith.transparency = 0.97
blocks.martian_dense_regolith.strength = 3

blocks.martian_stone = {}
blocks.martian_stone.texture = "textures/blocks/martian_stone1.png"
blocks.martian_stone.tileset_type = tilesets[1]
blocks.martian_stone.physics_type = "solid"
blocks.martian_stone.shadow = 0.7
blocks.martian_stone.transparency = 0.95
blocks.martian_stone.strength = 5

blocks.ice = {}
blocks.ice.texture = "textures/blocks/ice1.png"
blocks.ice.tileset_type = tilesets[1]
blocks.ice.physics_type = "powder"
blocks.ice.shadow = 0.8
blocks.ice.transparency = 0.98
blocks.ice.strength = 0.5

blocks.meteorite = {}
blocks.meteorite.texture = "textures/blocks/meteorite1.png"
blocks.meteorite.tileset_type = tilesets[1]
blocks.meteorite.physics_type = "solid"
blocks.meteorite.shadow = 0.7
blocks.meteorite.transparency = 0.95
blocks.meteorite.strength = 8

blocks.bricks = {}
blocks.bricks.texture = "textures/blocks/bricks1.png"
blocks.bricks.tileset_type = tilesets[1]
blocks.bricks.physics_type = "solid"
blocks.bricks.shadow = 0.7
blocks.bricks.transparency = 0.95
blocks.bricks.strength = 3

blocks.impure_steel = {}
blocks.impure_steel.texture = "textures/blocks/impure_steel1.png"
blocks.impure_steel.tileset_type = tilesets[1]
blocks.impure_steel.physics_type = "solid"
blocks.impure_steel.shadow = 0.6
blocks.impure_steel.transparency = 0.99
blocks.impure_steel.strength = 6

blocks.aluminum = {}
blocks.aluminum.texture = "textures/blocks/aluminum1.png"
blocks.aluminum.tileset_type = tilesets[1]
blocks.aluminum.physics_type = "solid"
blocks.aluminum.shadow = 0.6
blocks.aluminum.transparency = 0.99
blocks.aluminum.strength = 5

return blocks