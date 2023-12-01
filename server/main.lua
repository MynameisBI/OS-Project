require 'globals'

Menu = require 'src.menu.menu'
Load = require 'src.load.load'
Game = require 'src.game.game'
Server = require 'src.server'

function love.load(args)
  Gamestate.registerEvents()
  Gamestate.switch(Menu)
end

function love.update(dt)
    Server:update(dt)
end

function love.draw()

end