local BouncingImageDrawSystem = Class('BouncingImageDrawSystem')

function BouncingImageDrawSystem:initialize(images)
  self.images = images
end

function BouncingImageDrawSystem:draw(imageData)
  local image = self.images[imageData.id]

  love.graphics.setColor(1, 1, 1)
  love.graphics.draw(image, imageData.x, imageData.y,
      0, 1080 / image:getWidth() * 0.1, 1080 / image:getHeight() * 0.1)
end

return BouncingImageDrawSystem