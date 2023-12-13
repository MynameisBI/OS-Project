-- menu.lua
local Button = require 'src.menu.button'

local Menu = {}

local BUTTON_WIDTH=love.graphics.getWidth() * (1/3)
local BUTTON_HEIGHT=64

function Menu:enter(previous)
    print("Hi")
    
    self.buttons = {}

    table.insert(self.buttons, Button(
    "Start Game 1", BUTTON_WIDTH, 50, BUTTON_WIDTH, BUTTON_HEIGHT,
    function() 
        Gamestate.switch(require 'src.load.load', {gameNumber = 1})
    end))

    table.insert(self.buttons, Button(
    "Start Game 2", BUTTON_WIDTH, 180, BUTTON_WIDTH, BUTTON_HEIGHT,
    function() 
        Gamestate.switch(require 'src.load.load', {gameNumber = 2})
    end))

    table.insert(self.buttons, Button(
    "Start Game 3", BUTTON_WIDTH, 310, BUTTON_WIDTH, BUTTON_HEIGHT,
    function() 
        Gamestate.switch(require 'src.load.load', {gameNumber = 3})
    end))

    table.insert(self.buttons, Button(
    "Exit Game", BUTTON_WIDTH, 440, BUTTON_WIDTH, BUTTON_HEIGHT,
    function() 
        love.event.quit(0)
    end))
end

function Menu:update(dt)
    Lume.each(self.buttons, 'update', dt)
end

function Menu:draw()
    Lume.each(self.buttons, 'draw')
end

return Menu
