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

return player
