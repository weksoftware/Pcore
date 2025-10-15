local shaders = {}

shaders.light = love.graphics.newShader("shaders/light.frag")
shaders.b4x4 = love.graphics.newShader("shaders/b4x4.frag")
shaders.tiles = love.graphics.newShader("shaders/tiles.frag")
shaders.bw = love.graphics.newShader("shaders/bw.frag")
shaders.bw_contrast = love.graphics.newShader("shaders/bw_contrast.frag")
shaders.contrast = love.graphics.newShader("shaders/contrast.frag")
shaders.rainbow = love.graphics.newShader("shaders/rainbow.frag")
shaders.notebook = love.graphics.newShader("shaders/notebook.frag")

return shaders