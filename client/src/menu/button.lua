local Button = Class('Button')

local MARGIN = 16

function Button:initialize(text, x, y, w, h, fn)
  self.text = text

  self.x, self.y, self.width, self.height = x, y, w, h

  self.font = Fonts.medium

  self.fn = fn or function() end
  self.now = false
  self.last = false

  self.playerIndexes = {}
end

function Button:addPlayerIndex(playerIndex)
  table.insert(self.playerIndexes, playerIndex)
end

function Button:removePlayerIndex(playerIndex)
  for i, playerIndex_ in ipairs(self.playerIndexes) do
    if playerIndex_ == playerIndex then
      table.remove(self.playerIndexes, i)
      break
    end
  end
end

function Button:update(dt)

end

function Button:draw()
    local w = love.graphics.getWidth()
    local h = love.graphics.getHeight()

    self.last = self.now

    local color= {1,1,1, 1.0}
    local mx, my = love.mouse.getPosition()
    local hot = mx > self.x and mx < self.x + self.width and
                my > self.y and my < self.y + self.height
    if hot then
        color = {0.5, 0.5, 0.5, 1.0}
    end

    self.now = love.mouse.isDown(1)
    if self.now and not self.last and hot then
        self.fn()
    end

    love.graphics.setColor(color)
    love.graphics.rectangle(
        "fill",
        self.x,
        self.y,
        self.width,
        self.height
    )

    love.graphics.setColor(0,0,0,1)

    local textW = self.font:getWidth(self.text)
    local textH = self.font:getHeight()

    love.graphics.print(
        self.text,
        self.font,
        self.x + self.width * 0.5 - textW * 0.5,
        self.y + textH * 0.5
    )
end

return Button