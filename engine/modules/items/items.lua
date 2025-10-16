local items = {}

items.steel_block = {
    texture="media/textures/items/steel_block1.png",
    block="steel",
    func="simple_build"
}
items.impure_steel_block = {
    texture="media/textures/items/impure_steel_block1.png",
    block="impure_steel",
    func="simple_build"
}
items.aluminum_block = {
    texture="media/textures/items/aluminum_block1.png",
    block="aluminum",
    func="simple_build"
}
items.match = {
    texture="media/textures/items/match1.png",
    func="match"
}
items.impure_steel_pickaxe = {
    texture="media/textures/items/impure_steel_pickaxe1.png",
    pickaxe_speed=25,
    func="pickaxe"
}
return items