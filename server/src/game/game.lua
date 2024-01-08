--Create empty gamestate 
-- 1 table has 4 arrays images, images[4] -> access image at id 4
--- position[x, y], direction[x,y], speed(optional) => each thread is used to compute this
--- position.x = dir.x + speed

--- What will have: 
--- What should be done: return imageId with the new location to to clients, also where they already type -> 2 arrays: 1 what should be type, 1 what already typed
--- with one character got typed one image will be spawned
local TextBox = require 'src.game.textBox'
local BouncingImage = require 'src.game.bouncingImage'


-- local Loader = require 'libs.love-loader'
local Game = {}

function Game:enter(from, gameTheme)
  self.gameTheme = gameTheme
  self.words = {}

  local wordArray = {}
  local totalWords = 0
  if(gameTheme == 'dog') then
    local DogBreedsFile = io.open("assets/DogBreeds.txt", "r")
    for line in DogBreedsFile:lines() do 
      table.insert(wordArray, line)
      totalWords = totalWords + 1
    end
  else
    local CatBreedsFile = io.open("assets/CatBreeds.txt", "r")
    for line in CatBreedsFile:lines() do 
      table.insert(wordArray, line)
      totalWords = totalWords + 1
    end
  end

  for i=1, 10 do
    local randomWord
    repeat
      local index = math.random(1, totalWords)
      randomWord = wordArray[index]

      local wordExists = false
      for _, word in ipairs(self.words) do
        if(word == randomWord) then
          wordExists = true
          break
        end
      end
    until not wordExists
    table.insert(self.words, (randomWord):lower())
  end
      

  self.textBoxes = {
    TextBox(), TextBox(), TextBox(), TextBox(),
  }

  -- self.positions = {}
  -- self.directions = {}
  -- self.speeds = {}
  -- self.alive = true
  -- self.imageData = {}

  self.clientImages = {{}, {}, {}, {}}

  --Create thread for each client
  self.threads = {}
  for i = 1, 4 do
    self.threads[i] = love.thread.newThread([[
      local clientIndex, imageDatas, dt = ...

      for i = 1, #imageDatas do
        --If image is out of bound, change direction
        if (imageDatas[i].x < 0 and imageDatas[i].dirX < 0) or
            (imageDatas[i].x > 1080 - 60 and imageDatas[i].dirX > 0) then
          imageDatas[i].dirX = -imageDatas[i].dirX
        end
        if (imageDatas[i].y < 0 and imageDatas[i].dirY < 0) or
          (imageDatas[i].y > 640 - 60 and imageDatas[i].dirY > 0) then
          imageDatas[i].dirY = -imageDatas[i].dirY
        end

        imageDatas[i].x = imageDatas[i].x + imageDatas[i].speed * imageDatas[i].dirX * dt
        imageDatas[i].y = imageDatas[i].y + imageDatas[i].speed * imageDatas[i].dirY * dt
      end

      love.thread.getChannel('imageData'..tostring(clientIndex)):push(imageDatas)
    ]])
  end
end

function Game:spawn(key, clientId)
  local x, y = 540, 320
  local dirX, dirY = Lume.vector(math.random() * math.pi * 2, 1)
  local speed = math.random(150, 250)
  table.insert(self.clientImages[clientId],
      BouncingImage(math.random(1, 100), x, y, dirX, dirY, speed))
end

function Game:update(dt)
  for clientIndex = 1, 4 do
    local imageDatas = love.thread.getChannel('imageData'..tostring(clientIndex)):pop()
    if imageDatas then
      for i = 1, #imageDatas do
        self.clientImages[clientIndex][i]:setImageData('thread', imageDatas[i])
      end
    end
  end

  for clientIndex = 1, 4 do
    if not self.threads[clientIndex]:isRunning() then
      local imageDatas = {}
      for i = 1, #self.clientImages[clientIndex] do
        imageDatas[i] = self.clientImages[clientIndex][i]:getImageData('thread')
      end

      self.threads[clientIndex]:start(clientIndex, imageDatas, dt)
    end
  end


  local textBoxes = {}
  for i = 1, 4 do 
    table.insert(textBoxes, {
      currentCharacters = self.textBoxes[i].currentCharacters,
      typedCharacters = self.textBoxes[i].typedCharacters,
      score = self.textBoxes[i].score,
    })
  end
  --Send new imageData to all clients
  local imageDatas = {}
  for clientIndex = 1, 4 do
    for i = 1, #self.clientImages[clientIndex] do
      table.insert(imageDatas, self.clientImages[clientIndex][i]:getImageData('packet'))
    end
  end
  Server:sendToAll('updateGame', {
    textBoxes = textBoxes,
    imageDatas = imageDatas,
  })
end

function Game:draw()
end


function Game:stop()
  self.alive = false
end

function Game:isAlive()
  return self.alive
end

return Game
