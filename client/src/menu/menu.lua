-- menu.lua
local Button = require 'src.menu.button'

local Menu = {}

local BUTTON_WIDTH = 160
local BUTTON_HEIGHT = 160

function Menu:enter(previous)
    print("Entered Menu State")
    self.buttons = {
        Button(
            "CAT", Images.ui.catButton,
            160, 175, BUTTON_WIDTH, BUTTON_HEIGHT,
            function(b) Gamestate.switch(Load, 'cat') end,
            function(b) self.currentHoveredButton = b end
        ),
        Button(
            "DOG", Images.ui.dogButton,
            460, 175, BUTTON_WIDTH, BUTTON_HEIGHT,
            function(b) Gamestate.switch(Load, 'dog') end,
            function(b) self.currentHoveredButton = b end
        ),
        Button(
            "SKELETON", Images.ui.skeletonButton,
            760, 175, BUTTON_WIDTH, BUTTON_HEIGHT,
            function(b) Gamestate.switch(Load, 'skeleton') end,
            function(b) self.currentHoveredButton = b end
        ),
        Button(
            "Exit Game", nil, 700, 540, 320, 60,
            function(b) love.event.quit(0) end
        ),
    }
    self.currentHoveredButton = nil
end

function Menu:update(dt)
  
end

function Menu:draw()
    Lume.each(self.buttons, 'draw')
end

return Menu
