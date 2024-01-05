--Create empty gamestate 
-- 1 table has 4 arrays images, images[4] -> access image at id 4
--- position[x, y], direction[x,y], speed(optional) => each thread is used to compute this
--- position.x = dir.x + speed

--- What will have: 
--- What should be done: return imageId with the new location to to clients, also where they already type -> 2 arrays: 1 what should be type, 1 what already typed
--- with one character got typed one image will be spawned
local TextBox = require 'src.game.textBox'

-- local Loader = require 'libs.love-loader'
local Game = {}

function Game:enter(from, gameNumber)
  self.words = {'never', 'gonna', 'give', 'you', 'up'}

  self.textBoxes = {
    TextBox(), TextBox(), TextBox(), TextBox(),
  }

  self.positions = {}
  self.directions = {}
  self.speeds = {}
  self.alive = true
  self.imageData = {}
end

function Game:spawn(key, clientId)
  -- self.positions[clientId] = {x = 540, y = 320}
  -- self.directions[clientId] = {x = math.random(-1, 1), y = math.random(-1, 1)}
  -- self.speeds[clientId] = math.random(1, 10)
end

function Game:update(dt)
  --Create thread for each client
  -- for clientId, thread in pairs(self.threads) do
  --   thread:start(function()
  --     for id, _ in pairs(self.images) do
  --       self.positions[id].x = self.positions[id].x + self.directions[id].x * self.speeds[id]
  --       self.positions[id].y = self.positions[id].y + self.directions[id].y * self.speeds[id]

  --       --If image is out of bound, change direction
  --       if self.positions[id].x < 0 or self.positions[id].x > 1080 then
  --         self.directions[id].x = -self.directions[id].x
  --       end
  --       if self.positions[id].y < 0 or self.positions[id].y > 720 then
  --         self.directions[id].y = -self.directions[id].y
  --       end

  --       --Update image position
  --       self.imageData[id] = {x = self.positions[id].x, y = self.positions[id].y}
  --     end
  --   end)
  -- end

  --Send new imageData to all clients
  -- Server:sendToAll('updateGame', self.imageData) 
  local textBoxes = {}
  for i = 1, 4 do 
    table.insert(textBoxes, {
      currentCharacters = self.textBoxes[i].currentCharacters,
      typedCharacters = self.textBoxes[i].typedCharacters,
      score = self.textBoxes[i].score,
    })
  end

  Server:sendToAll('updateGame', {
    textBoxes = textBoxes
  })
end


-- function Game:keypressed(key, client)
--   local clientId = Server.findClientIndex(client)
--   Game:spawn(key, clientId)
-- end

function Game:draw()
end


function Game:stop()
  self.alive = false
end

function Game:isAlive()
  return self.alive
end

return Game
