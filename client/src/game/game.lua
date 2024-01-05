-- game.lua
local TextBox = require 'src.game.textBox'
local BouncingImageDrawSystem = require 'src.game.bouncingImageDrawSystem'

local Game = {}

local SW, SH = love.graphics.getDimensions()


function Game:enter(previous, gameTheme, images)
    self.gameTheme = gameTheme

    self.textBoxes = {
        TextBox(1, SW * 0.25, SH * 0.25),
        TextBox(2, SW * 0.75, SH * 0.25),
        TextBox(3, SW * 0.25, SH * 0.75),
        TextBox(4, SW * 0.75, SH * 0.75),
    }

    self.imageDatas = {}
    self.bouncingImageDrawSystem = BouncingImageDrawSystem(images)
end

function Game:update(dt)
    Lume.each(self.textBoxes, 'update', dt)
end

function Game:draw()
    for i = 1, #self.imageDatas do
        self.bouncingImageDrawSystem:draw(self.imageDatas[i])
    end

    Lume.each(self.textBoxes, 'draw')

    love.graphics.setColor(0.9, 0.9, 0.9, 0.7)
    love.graphics.setFont(Fonts.small)
    love.graphics.print("Current game theme: ".. self.gameTheme)
    love.graphics.print("Press 'Escape' to go back to the menu", 0, 24)
end

function Game:keypressed(key, scancode, isRepeat)
    if key == 'escape' then
        Gamestate.switch(Menu)
    end
end

return Game
