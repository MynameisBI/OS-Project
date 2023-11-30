require 'globals'

Menu = require 'src.menu.menu'
Load = require 'src.load.load'
Game = require 'src.game.game'
Network = require 'src.network'

function love.load(args)
    Network:connect()
end

function love.update(dt)
    Network:update(dt)
end

function love.draw()

end