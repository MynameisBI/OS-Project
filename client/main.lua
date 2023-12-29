require 'globals'

Menu = require 'src.menu.menu'
Load = require 'src.load.load'
Game = require 'src.game.game'
Client = require 'src.client'

function love.load(args)
  love.graphics.setBackgroundColor(56/255, 41/255, 83/255)
  -- Gamestate.switch(Game)
  -- Gamestate.registerEvents()
  Client:connect()
end

function love.update(dt)
  Client:update(dt)
end

function love.draw()

end

function love.keypressed(key, scancode)
  Client:send('keyPressed', scancode)
end