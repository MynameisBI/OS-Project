local Button = Class('Button')

local MARGIN = 16

function Button:initialize(text, image, x, y, w, h, onHit, onHovered)
  self.text = text

  self.image = image

  self.x, self.y, self.width, self.height = x, y, w, h
  self.sx, self.sy = 1, 1

  self.font = Fonts.medium

  self.onHit = onHit or function() end
  self.onHovered = onHovered or function() end

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
    self.last = self.now

    local color= {1,1,1, 1.0}
    local mx, my = love.mouse.getPosition()
    local hot = mx > self.x and mx < self.x + self.width and
                my > self.y and my < self.y + self.height
    if hot then
        self.onHovered(self)
        color = {0.5, 0.5, 0.5, 1.0}
    else

    end

    self.now = love.mouse.isDown(1)
    if self.now and not self.last and hot then
        self.onHit(self)
    end

    love.graphics.setColor(color)
    if self.image then
      love.graphics.draw(self.image, self.x, self.y, 0,
          self.width / self.image:getWidth(), self.height / self.image:getHeight())

      love.graphics.setColor(1, 1, 1)
      love.graphics.printf(
        self.text,
        self.font,
        self.x - 40,
        self.y + self.height + 12,
        self.width + 80,
        'center'
      )

    else
      love.graphics.rectangle(
        "fill",
        self.x,
        self.y,
        self.width,
        self.height
      )

      love.graphics.setColor(0, 0, 0)
      love.graphics.printf(
        self.text,
        self.font,
        self.x - 40,
        self.y + self.height / 2 - self.font:getHeight() / 2,
        self.width + 80,
        'center'
      )

    end
end

return Button