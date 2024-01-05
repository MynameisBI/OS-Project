-- return function(animalType) --dog or cat
--     local images = {}
--         for player = 1, 4 do
--             images[player] = {}
--             for imageId = 1, 150 do
--                 local imagePath = string.format("client/assets/%s(%d)", animalType, imageNumber)
--                 images[player][imageId] = imagePath
--             end
--         end
--     return images --images[1][1] -> imageId 1 of player 1
-- end

local BouncingImage = Class('BouncingImage')

local SIZE = 1080
-- local SCALE = 

function BouncingImage:initialize(id, x, y, dirX, dirY, speed)
  self.id = id

  self.x, self.y = x, y

  self.dirX = dirX
  self.dirY = dirY

  self.speed = speed
end

function BouncingImage:setImageData(mode, data)
  if mode == 'thread' then
    self.x = data.x
    self.y = data.y
    self.dirX = data.dirX
    self.dirY = data.dirY
    self.speed = data.speed

  elseif mode == 'packet' then
    self.x = data.x
    self.y = data.y
  end
end

function BouncingImage:getImageData(mode)
  if mode == 'thread' then
    return {
      x = self.x,
      y = self.y,
      dirX = self.dirX,
      dirY = self.dirY,
      speed = self.speed,
    }

  elseif mode == 'packet' then
    return {
      id = self.id,
      x = self.x,
      y = self.y
    }
  end
end

return BouncingImage