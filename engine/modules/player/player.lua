local player = {}

player.x = 50
player.y = 25
player.moving = {}
player.moving.right = false
player.moving.left = false
player.moving.up = false
player.moving.down = false
player.orientation = "down"
player.jump = nil
player.fall = 0

player.camera = {}
player.camera.x = 0
player.camera.y = 0
player.camera.zoom = 1

player.chat = {}
player.chat_size = 0
player.chat_status = 'close'
player.chat_scroll = 0

player.inventory = {}
player.inventory[3] = {name="steel_block", count=1000}
player.inventory[1] = {name="impure_steel_block", count=1000}
player.inventory[2] = {name="match", count=500}
player.inventory[4] = {name="impure_steel_pickaxe", count=1}
player.inventory[5] = {name="aluminum_block", count=1000}
player.inventory_select = 3

return player
