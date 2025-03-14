local shaders = {}

shaders.bw = love.graphics.newShader("shaders/bw.frag")
shaders['4x4'] = love.graphics.newShader("shaders/4x4.frag")
shaders.rainbow = love.graphics.newShader("shaders/rainbow.frag")
shaders.light = love.graphics.newShader("shaders/light.frag")

return shaders