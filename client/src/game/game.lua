-- game.lua
local TextBox = require 'src.game.textBox'

local Game = {}

function Game:enter(previous, gameNumber)
    self.gameNumber= gameNumber or 1
    
    self.textBoxes = {
        TextBox(1, 200, 125, 200, 60),
        TextBox(2, 700, 125, 200, 60),
        TextBox(3, 200, 425, 200, 60),
        TextBox(4, 700, 425, 200, 60),
    }
end

function Game:update(dt)
    -- Code to update the state 

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
