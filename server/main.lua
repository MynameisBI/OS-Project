require 'globals'

Menu = require 'src.menu.menu'
Load = require 'src.load.load'
Game = require 'src.game.game'
Server = require 'src.server'

local logs = {
  'Server is running...',
}

function love.load(args)
  Gamestate.registerEvents()
  Gamestate.switch(Menu)
end

function love.update(dt)
  Server:update(dt)
end

function love.draw()
  for i = 1, #logs do
    love.graphics.print(logs, 0, (i-1) * 12)
  end
end