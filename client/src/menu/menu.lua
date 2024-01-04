-- menu.lua
local Button = require 'src.menu.button'

local Menu = {}

local BUTTON_WIDTH = 160
local BUTTON_HEIGHT = 160

function Menu:enter(previous)
    self.buttons = {
        Button(
            "CAT", Images.ui.catButton,
            160, 200, BUTTON_WIDTH, BUTTON_HEIGHT,
            function(b) Gamestate.switch(Load, {gameNumber = 1}) end,
            function(b) self.currentHoveredButton = b end
        ),
        Button(
            "DOG", Images.ui.dogButton,
            460, 200, BUTTON_WIDTH, BUTTON_HEIGHT,
            function(b) Gamestate.switch(Load, {gameNumber = 2}) end,
            function(b) self.currentHoveredButton = b end
        ),
        Button(
            "SKELETON", Images.ui.skeletonButton,
            760, 200, BUTTON_WIDTH, BUTTON_HEIGHT,
            function(b) Gamestate.switch(Load, {gameNumber = 3}) end,
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
    --Retrieve serverResponse here
    local serverResponses = {
        { h = {true, true, true, true}, s = {false, false, false, false} },
        { h = {false, false, false, false}, s = {true, true, true, true} },
        { h = {true, true, false, false}, s = {false, false, true, true} },
        { h = {false, false, true, true}, s = {true, true, false, false} }
    }

    for i, button in ipairs(self.buttons) do
        button:update(dt, serverResponses[i].h, serverResponses[i].s)
    end
end

function Menu:draw()
    Lume.each(self.buttons, 'draw')
end

return Menu
