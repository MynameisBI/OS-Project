local BouncingImageDrawSystem = Class('BouncingImageDrawSystem')

function BouncingImageDrawSystem:initialize(gameTheme, images)
  self.border = Images.ui[gameTheme..'Button']
  self.images = images
end

function BouncingImageDrawSystem:draw(imageData)
  local image = self.images[imageData.id]

  love.graphics.setColor(1, 1, 1)
  love.graphics.draw(self.border, imageData.x - 4, imageData.y - 4,
      0, 48 / self.border:getWidth(), 48 / self.border:getHeight())
  love.graphics.draw(image, imageData.x, imageData.y,
      0, 40 / image:getWidth(), 40 / image:getHeight())
end

return BouncingImageDrawSystem