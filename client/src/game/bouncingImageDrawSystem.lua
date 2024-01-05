local BouncingImageDrawSystem = Class('BouncingImageDrawSystem')

function BouncingImageDrawSystem:initialize(images)
  self.images = images
end

function BouncingImageDrawSystem:draw(imageData)
  local image = self.images[imageData.id]

  love.graphics.setColor(1, 1, 1)
  love.graphics.draw(image, imageData.x, imageData.y,
      0, 1080 / image:getWidth() * 0.05, 1080 / image:getHeight() * 0.05)
end

return BouncingImageDrawSystem