local map = {}

map.map = {}

for x = 1, 80 do
    map.map[x] = {}
    for y = 1, 60 do
        noise = love.math.noise(x/50, y/50)
        map.map[x][y] = {block="air"}
        if noise < 0.3 then
            map.map[x][y].block = "rnd"
            map.map[x][y].color = love.math.random(256)
        end
    end
end

return map