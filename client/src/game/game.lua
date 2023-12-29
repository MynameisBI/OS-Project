-- game.lua
local TextBox = require 'src.game.textBox'

local Game = {}

local SW, SH = love.graphics.getDimensions()

function Game:enter(previous, gameNumber)
    self.gameNumber= gameNumber or 1
    
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
end

function Game:keypressed(key, scancode, isRepeat)
    Lume.each(self.textBoxes, 'keypressed', key, scancode, isRepeat)

    if key == 'escape' then
        Gamestate.switch(require 'src.menu.menu')
    end
end

return Game
