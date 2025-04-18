local blocks = require("level_three/blocks")
local tilesets = require("level_three/tilesets")
local data = require("level_three/data")
local json = require("level_three/json")
local planets = require("level_three/planets")
local player = require("level_three/player")
local sprites = require("level_three/sprites")
local items = require("level_two/items")

local funcs = {}

local combinations = { -- комбинации постановки блоков
    oooo = 9,
    oooi = 8,
    ooio = 6,
    ooii = 7,
    oioo = 4,
    oioi = 15,
    oiio = 5,
    oiii = 12,
    iooo = 2,
    iooi = 1,
    ioio = 14,
    ioii = 13,
    iioo = 3,
    iioi = 10,
    iiio = 11,
    iiii = 16,
    assa = 17,
    aass = 18,
    saas = 19,
    ssaa = 20

}

function funcs.img_load(path)
    local img = love.graphics.newImage(path)
    img:setFilter("nearest", "nearest")
    return img
end

function funcs.block_img_load(path, tileset)
    local textures = {}
    local tiles = love.image.newImageData(path)

    for i = 1, 20 do
        local cropped = love.image.newImageData(8, 8)
        cropped:paste(tiles, 0, 0, tileset[i].x * 8, tileset[i].y * 8, 8, 8)
        local img = love.graphics.newImage(cropped)
        img:setFilter("nearest", "nearest")
        textures[i] = img
    end

    return textures
end

function funcs.multiblock_img_load(path, tileset)
    local textures = {}
    local tiles = love.image.newImageData(path)
    local i = 1

    for y = 0, 7 do
        for x = 0,7 do
            local cropped = love.image.newImageData(8, 8)
            cropped:paste(tiles, 0, 0, x * 8, y * 8, 8, 8)
            local img = love.graphics.newImage(cropped)
            img:setFilter("nearest", "nearest")
            textures[i] = img
            i = i + 1
        end
    end

    return textures
end

function funcs.animation_img_load(path, count)
    local textures = {}
    local tiles = love.image.newImageData(path)

    for i = 0, count - 1 do
        local cropped = love.image.newImageData(8, 8)
        cropped:paste(tiles, 0, 0, i * 8, 0, 8, 8)
        local img = love.graphics.newImage(cropped)
        img:setFilter("nearest", "nearest")
        textures[i + 1] = img
    end

    return textures
end

function funcs.blocks_imgs_load()
    for block, value in pairs(blocks) do
        if blocks[block].texture ~= nil then
            if blocks[block].multiblock == nil then
                blocks[block].texture = funcs.block_img_load(blocks[block].texture, blocks[block].tileset_type)
            else
                blocks[block].texture = funcs.multiblock_img_load(blocks[block].texture, blocks[block].tileset_type)
            end
        end
    end
end

function funcs.sprite_img_load(path)
    local sprite = {}
    sprite.img = love.graphics.newImage(path)
    sprite.img:setFilter("nearest", "nearest")
    sprite.h = sprite.img:getPixelHeight()
    sprite.w = sprite.img:getPixelWidth()
    return sprite
end

function funcs.sprites_imgs_load()
    for sprite, path in pairs(sprites) do
        sprites[sprite] = funcs.sprite_img_load(path)
    end
    for item, value in pairs(items) do
        if items[item].texture ~= nil then
            sprites[item] = funcs.sprite_img_load(items[item].texture)
        end
    end
end

function funcs.coordx(x, h, w)
    if x < 1 then
        x = x % w
        return w + x
    elseif x > w then
        return x % w
    else
        return x
    end
end

function funcs.coordy(y, h, w)
    if y < 1 then
        y = y % h
        return h + y
    elseif y > h then
        return y % h
    else
        return y
    end
end

function funcs.select_block_img(planet, x, y, h, w)
    local block = planet[x][y].block
    local combination = ''

    if planet[x][funcs.coordy(y-1, h, w)].block == block then
        combination = combination .. 'o'
    else
        combination = combination .. 'i'
    end

    if planet[funcs.coordx(x+1, h, w)][y].block == block then
        combination = combination .. 'o'
    else
        combination = combination .. 'i'
    end

    if planet[x][funcs.coordy(y+1, h, w)].block == block then
        combination = combination .. 'o'
    else
        combination = combination .. 'i'
    end

    if planet[funcs.coordx(x-1, h, w)][y].block == block then
        combination = combination .. 'o'
    else
        combination = combination .. 'i'
    end

    -- -------------------------------------------

    local air_combination = ''

    if blocks[block].tileset_type == tilesets[1] then

        if planet[x][funcs.coordy(y-1, h, w)].block == 'air' then
            air_combination = air_combination .. 'a'
        else
            air_combination = air_combination .. 's'
        end

        if planet[funcs.coordx(x+1, h, w)][y].block == 'air' then
            air_combination = air_combination .. 'a'
        else
            air_combination = air_combination .. 's'
        end

        if planet[x][funcs.coordy(y+1, h, w)].block == 'air' then
            air_combination = air_combination .. 'a'
        else
            air_combination = air_combination .. 's'
        end

        if planet[funcs.coordx(x-1, h, w)][y].block == 'air' then
            air_combination = air_combination .. 'a'
        else
            air_combination = air_combination .. 's'
        end
    end

    -- ----------------------------------------------

    if air_combination == 'aass' or air_combination == 'assa' or air_combination == 'saas' or air_combination == 'ssaa' then
        return combinations[air_combination]
    else
        return combinations[combination]
    end

end

function funcs.is_not_full_block(r)
    if r ~= 20 and r ~= 19 and r ~= 18 and r ~= 17 then
        return false
    else
        return true
    end
end

function funcs.select_background_img(planet, x, y, h, w)
    local block = planet[x][y].background
    local combination = ''

    if planet[x][funcs.coordy(y-1, h, w)].background == block then
        combination = combination .. 'o'
    else
        combination = combination .. 'i'
    end

    if planet[funcs.coordx(x+1, h, w)][y].background == block then
        combination = combination .. 'o'
    else
        combination = combination .. 'i'
    end

    if planet[x][funcs.coordy(y+1, h, w)].background == block then
        combination = combination .. 'o'
    else
        combination = combination .. 'i'
    end

    if planet[funcs.coordx(x-1, h, w)][y].background == block then
        combination = combination .. 'o'
    else
        combination = combination .. 'i'
    end
    -- ----------------------------------------------
    return combinations[combination]

end

function funcs.array_size(array)
    local count = 0
    for _ in pairs(array) do 
        count = count + 1
    end
    return count
end

function funcs.create_message(player, text, time, rc, gc, bc)
    local message = {text=text, time=time, w=nil, color={r=rc/255, g=gc/255, b=bc/255}}
    player.chat_size = player.chat_size + 1
    player.chat[player.chat_size] = message
    return player
end

function funcs.update_settings()
    love.window.setVSync(data.settings_values.vsync[data.settings.vsync])
    data.display_debug = data.settings_values.display_debug[data.settings.display_debug]
    player.camera.zoom = data.settings_values.zoom[data.settings.zoom]
end

function funcs.save_settings()
    love.filesystem.write("settings.json", json.encode(data.settings))
end

function funcs.save_map(name)
    love.filesystem.write("saves/" .. name, json.encode(planets))
end

function funcs.load_map(name)
    local save = json.decode(love.filesystem.read("saves/" .. name))
    planets.pcore = save.pcore
    planets.mars = save.mars
end

function funcs.reverse_sort(num1, num2)
    return num1 > num2
end

return funcs