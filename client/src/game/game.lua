-- game.lua
local TextBox = require 'src.game.textBox'

local Game = {}

local SW, SH = love.graphics.getDimensions()


function Game:enter(previous, gameNumber, images)
    self.gameNumber= gameNumber or 1
    self.images = images or {}
    self.positions = {}
    self.textBoxes = {
        TextBox(1, SW * 0.25, SH * 0.25),
        TextBox(2, SW * 0.75, SH * 0.25),
        TextBox(3, SW * 0.25, SH * 0.75),
        TextBox(4, SW * 0.75, SH * 0.75),
    }
end

function Game:update(dt)
    Lume.each(self.textBoxes, 'update', dt)
end

function Game:draw()
    Lume.each(self.textBoxes, 'draw')

    love.graphics.print("Entered Game ".. self.gameNumber, 50, 50)
    love.graphics.print("Press 'Escape' to go back to the menu  ")

    --if arrays of images and positions are not empty, draw them
    -- if(self.images ~= nil) then
    --     for clientId, image in pairs(self.images) do
    --         local position = self.positions[clientId]
    --         love.graphics.draw(image, position.x, position.y)
    --     end
    -- end
end

function Game:spawnImage(clientId)
    local imageId = math.random(1, 150)
    local imagePath = string.format("assets/cat/cat (%d).jpg", imageId) --TODO: change cat to animalType   %s(%d).png", cat, imageId
    local image = love.graphics.newImage(imagePath)
    self.images[clientId] = image
    self.positions[clientId] = { x = 540, y = 320 }
end

function Game:keypressed(key, scancode, isRepeat)
    -- local clientId = 1 --temporary, has to be changed later
    -- self:spawnImage(clientId)
    if key == 'escape' then
        Gamestate.switch(require 'src.menu.menu')
    end
end

return Game
