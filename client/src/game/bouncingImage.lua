local BouncingImage = Class('BouncingImage')

function BouncingImage:initialize(image, x, y)
  self.image = image
  self.x, self.y = x, y
end

function BouncingImage:draw()
  love.graphics.draw(self.image, self.x, self.y)
end

return BouncingImage