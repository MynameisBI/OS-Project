-- game.lua
local Game = {}

function Game:enter(previous, gameNumber)
    self.gameNumber= gameNumber
    -- Code to run when the state is entered
end

function Game:update(dt)
    -- Code to update the state
end

function Game:draw()
    love.graphics.print("Entered Game ".. self.gameNumber, 50, 50)
    love.graphics.print("Press 'Escape' to go back to the menu  ")
end

function Game:keypressed(key)
    if key == 'escape' then
        Gamestate.switch(require 'src.menu.menu')
    end
end

return Game
