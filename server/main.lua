require 'globals'

Menu = require 'src.menu.menu'
Load = require 'src.load.load'
Game = require 'src.game.game'
Server = require 'src.server'

local logs = {
  'Server is running...',
}

function love.load(args)
  math.randomseed(os.time())

  Gamestate.registerEvents()
  Gamestate.switch(Menu)
end

function love.update(dt)
  Server:update(dt)
  
  -- local isGameAlive = Game:isAlive()
  --   if(isGameAlive) then
  --     Game:update(dt)
  --   end
end

function love.draw()
  love.graphics.print("Server address: " .. Server:getAddress() .. ":" .. Server:getPort(), 0, 50)
  love.graphics.print("Total number of players: " ..  Server:getClientCount(), 0 , 100)

  -- local isGameAlive = Game:isAlive()
  -- -- if(isGameAlive) then
  -- --   Game:draw()
  -- -- end
end