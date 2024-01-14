-- loading.lua

local loader = require 'libs.love-loader'
local finishedLoading = false


local rotationAngle = 0

local Loading = {}

function Loading:enter(previous, gameTheme)
  print("Entered Loading State")
  self.gameTheme = gameTheme

  rotationAngle = 0
  self.throbber = Images.ui[gameTheme..'Button']

  self.images = {}
  local imageCount
  if gameTheme == 'cat' then imageCount = 150
  elseif gameTheme == 'dog' then imageCount = 150
  elseif gameTheme == 'skeleton' then imageCount = 135
  end
  for i = 1, imageCount do
    loader.newImage(self.images, i,
        ('assets/%s/%s (%d).jpg'):format(gameTheme, gameTheme, i))
  end

  loader.start(function()
    finishedLoading = true
    Client:send('completeLoad')
  end)
end

function Loading:update(dt)
  if not finishedLoading then
    loader.update() --Do on each iteration until all resources are loaded
  end

  rotationAngle = rotationAngle + dt * 3.5

  if finishedLoading then

  end
end

function Loading:draw()
  love.graphics.setColor(1,1,1)

  local percent = 0
  if loader.resourceCount ~= 0 then percent = loader.loadedCount / loader.resourceCount end

  if finishedLoading then 
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

  love.graphics.stencil(function()
    local w, h = Images.ui.emptyBar:getDimensions()
    local w, h = w * 0.275, h * 0.275
    love.graphics.rectangle('fill', x - w / 2, y - h / 2, w * percent, h)
  end, 'replace', 1)
  love.graphics.setStencilTest('greater', 0)
  love.graphics.draw(Images.ui.progress, x, y, 0, 0.275, 0.275,
      Images.ui.progress:getWidth() / 2, Images.ui.progress:getHeight() / 2)
  love.graphics.setStencilTest()

  love.graphics.setColor(1, 1, 1)
  love.graphics.draw(self.throbber, love.graphics.getWidth() / 2, 245,
      rotationAngle, 0.2, 0.2,
      self.throbber:getWidth() / 2, self.throbber:getHeight() / 2)
end


return Loading
