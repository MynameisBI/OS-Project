--Create empty gamestate 
-- 1 table has 4 arrays images, images[4] -> access image at id 4
--- position[x, y], direction[x,y], speed(optional) => each thread is used to compute this
--- position.x = dir.x + speed

--- What will have: 
--- What should be done: return imageId with the new location to to clients, also where they already type -> 2 arrays: 1 what should be type, 1 what already typed
--- with one character got typed one image will be spawned

local Loader = require 'libs.love-loader'
-- local loadImages = require 'src/game/images'
local Game = {}

function Game:load()
  -- self.images = loadImages(animalType) --dog or cat
  self.positions = {}
  self.directions = {}
  self.speeds = {}
  self.alive = true
end

function Game:spawn(key, clientId)
  local imageId = math.random(1, 150)
  -- local image = self.images[clientId][imageId]s
  self.positions[clientIdd] = {x = math.random(0, 1000), y = math.random(0, 1000)}
  self.directions[clientIdd] = {x = math.random(-1, 1), y = math.random(-1, 1)}
  self.speeds[clientId] = math.random(1, 10)
end

function Game:update(dt)
  --Create thread for each client
  for clientId, thread in pairs(self.threads) do
    thread:start(function()
      -- for id, _ in pairs(self.images) do
      --   self.positions[id].x = self.positions[id].x + self.directions[id].x * self.speeds[id]
      --   self.positions[id].y = self.positions[id].y + self.directions[id].y * self.speeds[id]
      -- end
    end)
  end
end


function love.keypressed(key, client)
  local clientId = Server.findClientIndex(client)
  Game:spawn(key, clientId)
end

function Game:draw()
  -- for clientId, _ in pairs(self.images) do
  --   for id, image in pairs(self.images[clientId]) do
  --     local position = self.positions[clientId]
  --     if position then
  --       love.graphics.draw(image, position.x, position.y)
  --     end
  --   end
  -- end  
end


function Game:stop()
  self.alive = false
end

function Game:isAlive()
  return self.alive
end

return Game
