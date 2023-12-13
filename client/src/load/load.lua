-- loading.lua
local rotationAngle = 0
local rectangleSize = 50
local loadingTimer = 0
local loadingDuration = 3

local Loading = {}

function Loading:init()
    self.gameNumber = nil  -- Initialize self.gameNumber
end

function Loading:enter(previous, gameNr)
    self.gameNumber = gameNr.gameNumber
    rotationAngle = 0
    loadingTimer = 0
end

function Loading:update(dt)
    rotationAngle = rotationAngle + dt * 2 * math.pi
   -- Update the loading timer
    loadingTimer = loadingTimer + dt

   -- Check if loading is complete
    if loadingTimer >= loadingDuration then
        Gamestate.switch(require 'src.game.game', self.gameNumber)
    end
end

function Loading:draw()
    love.graphics.print("Loading: Game ".. self.gameNumber, 50, 50)

    love.graphics.setColor(1, 0, 0)  -- Set color to red
    love.graphics.push()  -- Save the current transformation state
    love.graphics.translate(love.graphics.getWidth() / 2, love.graphics.getHeight() / 2)  -- Translate to the center
    love.graphics.rotate(rotationAngle)  -- Rotate
    love.graphics.rectangle("fill", -rectangleSize / 2, -rectangleSize / 2, rectangleSize, rectangleSize)  -- Draw centered rectangle
    love.graphics.pop()  -- Restore the previous transformation state
    love.graphics.setColor(1, 1, 1)  -- Reset color to white
end


return Loading
