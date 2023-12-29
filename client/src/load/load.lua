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


  local x, y = love.graphics.getWidth() / 2, 560
  love.graphics.setColor(1, 1, 1)
  love.graphics.draw(Images.ui.emptyBar, x, y,
      0, 0.275, 0.275, Images.ui.emptyBar:getWidth() / 2, Images.ui.emptyBar:getHeight() / 2)

  love.graphics.stencil(function()
    local w, h = Images.ui.emptyBar:getDimensions()
    local w, h = w * 0.275, h * 0.275
    love.graphics.rectangle('fill', x - w / 2, y - h / 2, w * loadingTimer / loadingDuration, h)
  end, 'replace', 1)
  love.graphics.setStencilTest('greater', 0)
  love.graphics.draw(Images.ui.progress, x, y, 0, 0.275, 0.275,
      Images.ui.progress:getWidth() / 2, Images.ui.progress:getHeight() / 2)
  love.graphics.setStencilTest()

  local text = 'LOADING'
  if loadingDuration then
    for i = 1, math.floor(loadingTimer / 0.5) % 4 do
      text = text..'.'
    end
  end
  love.graphics.setColor(0.96, 0.96, 0.96)
  love.graphics.setFont(Fonts.medium)
  love.graphics.printf(text, love.graphics.getWidth() / 2 - 400, 480, 800, 'center')
end


return Loading
