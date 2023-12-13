-- menu.lua

BUTTON_HEIGHT=64

local function newButton(text, fn)
    return{
        text = text,
        fn = fn,
        now = false,
        last = false
    }
end

local Menu = {}
local buttons ={}
local font = nil

function Menu:enter(previous)
    print("Hi")
    font = love.graphics.newFont(32)
    buttons = {}

    table.insert(buttons, newButton(
        "Start Game 1", 
        function() 
            Gamestate.switch(require 'src.load.load', {gameNumber = 1})
        end))

        table.insert(buttons, newButton(
        "Start Game 2", 
        function() 
            Gamestate.switch(require 'src.load.load', {gameNumber = 2})
        end))

        table.insert(buttons, newButton(
        "Start Game 3", 
        function() 
            Gamestate.switch(require 'src.load.load', {gameNumber = 3})
        end))

        table.insert(buttons, newButton(
        "Exit Game", 
        function() 
            love.event.quit(0)
        end))
end

function Menu:load()
    
end

function Menu:draw()
    love.graphics.clear()
    local w = love.graphics.getWidth()
    local h = love.graphics.getHeight()

    local button_width = w * (1/3)
    local margin = 16

    local total_height = (BUTTON_HEIGHT +margin) * #buttons
    local cursor_y = 0

    for i, button in ipairs(buttons) do
        button.last = button.now
        local bx = (w * 0.5) - (button_width * 0.5)
        local by = (h * 0.5) - (total_height * 0.5)
        + cursor_y

        local color= {1,1,1, 1.0}
        local mx, my = love.mouse.getPosition()
        local hot = mx > bx and mx < bx + button_width and
                    my > by and my < by + BUTTON_HEIGHT
        if hot then
            color = {0.5, 0.5, 0.5, 1.0}
        end

        button.now = love.mouse.isDown(1)
        if button.now and not button.last and hot then
            button.fn()
        end


        love.graphics.setColor(unpack(color))
        love.graphics.rectangle(
            "fill",
            bx,
            by,
            button_width,
            BUTTON_HEIGHT
        )

        love.graphics.setColor(0,0,0,1)

        local textW = font:getWidth(button.text)
        local textH = font:getHeight(button.text)

        love.graphics.print(
            button.text,
            font,
            (w * 0.5) - textW * 0.5,
            by + textH * 0.5
        )

        cursor_y = cursor_y + (BUTTON_HEIGHT + margin)
    end
end

function Menu:update(dt)
    -- code to update the state
end

return Menu
