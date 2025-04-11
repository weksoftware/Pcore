local player = {}

player.x = 0
player.y = 0
player.moving = {}
player.moving.right = false
player.moving.left = false
player.moving.up = false
player.moving.down = false

player.camera = {}
player.camera.zoom = 1

player.chat = {}
player.chat_size = 0
player.chat_status = 'close'
player.chat_scroll = 0

player.inventory = {}
player.inventory[3] = {name="steel_block", count=100}
player.inventory[1] = {name="impure_steel_block", count=100}
player.inventory[2] = {name="match", count=50}
player.inventory[4] = {name="impure_steel_pickaxe", count=1}
player.inventory[5] = {name="aluminum_block", count=100}
player.inventory_select = 3

return player
