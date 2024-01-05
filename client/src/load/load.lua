-- loading.lua

--love-loader
local loader = require 'libs.love-loader'
local finishedLoading = false


local rotationAngle = 0

local Loading = {}

function Loading:init()
    self.gameNumber = nil  -- Initialize self.gameNumber
end

function Loading:enter(previous, gameNr)
  print("Entered Loading State")
  self.gameNumber = gameNr.gameNumber

  rotationAngle = 0
  -- loadingTimer = 0
  if self.gameNumber == 1 then
    self.throbber = Images.ui.catButton
  elseif self.gameNumber == 2 then
    self.throbber = Images.ui.dogButton
  elseif self.gameNumber == 3 then
    self.throbber = Images.ui.skeletonButton
  end

  self.images = {}
  for i = 1, 150 do
    loader.newImage(self.images, 'cat' .. i, 'assets/cat/cat (' .. i .. ').jpg')
  end

  loader.start(function()
    finishedLoading = true
    Client:send('completeLoad')
  end)
end

function Loading:update(dt)
  --love-loader
  if not finishedLoading then
    loader.update() -- You must do this on each iteration until all resources are loaded
  end

  rotationAngle = rotationAngle + dt * 3.5

  --switch to game:
  if finishedLoading then
    -- print("Finished Loading State")
    -- Gamestate.switch(Game, self.gameNumber)
  end
end

function Loading:draw()
  love.graphics.setColor(1,1,1)

  local percent = 0
  if loader.resourceCount ~= 0 then percent = loader.loadedCount / loader.resourceCount end

  if finishedLoading then --not needed for game just do else part with  "if not finishedloading then"
--    for i = 1, 150 do
--      local key = 'cat' .. i
--      local x = (i - 100) * 10 
--      local y = 0
--      love.graphics.draw(images[key], x, y)
--    end
    love.graphics.setColor(0.96, 0.96, 0.96)
    love.graphics.setFont(Fonts.medium)
    love.graphics.print("Waiting for other people",
        love.graphics.getWidth() / 2 - Fonts.medium:getWidth("Waiting for other people") / 2, 480)
  else
    love.graphics.setColor(0.96, 0.96, 0.96)
    love.graphics.setFont(Fonts.medium)
    love.graphics.print(("Loading .. %d%%"):format(percent*100), love.graphics.getWidth() / 2 - 100, 480)
  end

  local x, y = love.graphics.getWidth() / 2, 560
  love.graphics.setColor(1, 1, 1)
  love.graphics.draw(Images.ui.emptyBar, x, y,
      0, 0.275, 0.275, Images.ui.emptyBar:getWidth() / 2, Images.ui.emptyBar:getHeight() / 2)

  -- Loading bar
  love.graphics.stencil(function()
    local w, h = Images.ui.emptyBar:getDimensions()
    local w, h = w * 0.275, h * 0.275
    love.graphics.rectangle('fill', x - w / 2, y - h / 2, w * percent, h)
  end, 'replace', 1)
  love.graphics.setStencilTest('greater', 0)
  love.graphics.draw(Images.ui.progress, x, y, 0, 0.275, 0.275,
      Images.ui.progress:getWidth() / 2, Images.ui.progress:getHeight() / 2)
  love.graphics.setStencilTest()

  --rotation:
  -- love.graphics.setColor(1, 1, 1)
  -- love.graphics.push()  -- Save the current transformation state
  -- love.graphics.translate(love.graphics.getWidth() / 2, love.graphics.getHeight() / 2)  -- Translate to the center
  -- love.graphics.rotate(rotationAngle)  -- Rotate
  -- love.graphics.draw(Images.ui.catButton)
  -- love.graphics.pop()  -- Restore the previous transformation state
  -- love.graphics.setColor(1, 1, 1)

  love.graphics.setColor(1, 1, 1)
  love.graphics.draw(self.throbber, love.graphics.getWidth() / 2, 245,
      rotationAngle, 0.2, 0.2,
      self.throbber:getWidth() / 2, self.throbber:getHeight() / 2)
end


return Loading
