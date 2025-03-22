local fonts = {}

fonts.list = {}

--Загрузка шрифтов по размеру экрана
function fonts.load_fonts()
    local width, height = love.graphics.getDimensions()
    local h_percento = height / 100
    for i = 1, 40 do
        fonts.list[i] = love.graphics.newFont("fonts/basis33/regular.ttf", h_percento * i / 2)
    end
end

return fonts