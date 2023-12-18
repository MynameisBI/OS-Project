require 'globals'

Menu = require 'src.menu.menu'
Load = require 'src.load.load'
Game = require 'src.game.game'
Client = require 'src.client'

function love.load(args)
  Client:connect()
end

function love.update(dt)
  Client:update(dt)
end

function love.draw()

end