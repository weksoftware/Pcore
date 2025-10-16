local shaders = {}

shaders.light = love.graphics.newShader("media/shaders/light.frag")
shaders.b4x4 = love.graphics.newShader("media/shaders/b4x4.frag")
shaders.tiles = love.graphics.newShader("media/shaders/tiles.frag")
shaders.bw = love.graphics.newShader("media/shaders/bw.frag")
shaders.bw_contrast = love.graphics.newShader("media/shaders/bw_contrast.frag")
shaders.contrast = love.graphics.newShader("media/shaders/contrast.frag")
shaders.rainbow = love.graphics.newShader("media/shaders/rainbow.frag")
shaders.notebook = love.graphics.newShader("media/shaders/notebook.frag")

return shaders