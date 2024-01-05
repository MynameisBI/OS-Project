local Button = Class('Button')

local HOVERED_MARGIN = 30
local LOCKED_MARGIN = 14

function Button:initialize(text, image, x, y, w, h, onHit, onHovered)
  self.text = text

  self.image = image

  self.x, self.y, self.width, self.height = x, y, w, h
  self.sx, self.sy = 1, 1

  self.font = Fonts.medium

  --old stuff: (to be removed)
  self.onHit = onHit or function() end
  self.onHovered = onHovered or function() end
  self.now = false
  self.last = false

  self.isHovered = {}  -- Initialize as a table of booleans
  self.isSelected = {}  -- Initialize as a table of booleans

  self.playerStatusHoveredPosOffsets = {
    {x = -HOVERED_MARGIN, y = -HOVERED_MARGIN},
    {x = HOVERED_MARGIN + self.width, y = -HOVERED_MARGIN},
    {x = HOVERED_MARGIN + self.width, y = HOVERED_MARGIN + self.height},
    {x = -HOVERED_MARGIN, y = HOVERED_MARGIN + self.height},
  }
  self.playerStatusLockedPosOffsets = {
    {x = -LOCKED_MARGIN, y = -LOCKED_MARGIN},
    {x = LOCKED_MARGIN + self.width, y = -LOCKED_MARGIN},
    {x = LOCKED_MARGIN + self.width, y = LOCKED_MARGIN + self.height},
    {x = -LOCKED_MARGIN, y = LOCKED_MARGIN + self.height},
  }
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

function Button:update(dt,isHovered, isSelected)
  assert(type(isHovered) == "table", "Invalid isHovered argument")
  assert(type(isHovered) == "table", "Invalid isSelected argument")

  self.isHovered = isHovered
  self.isSelected = isSelected
end

function Button:draw()
  love.graphics.setColor(1, 1, 1)

--code for mouse
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
    

--code for buttons
    love.graphics.setColor(color)
    if self.image then
      love.graphics.draw(
        self.image,
        self.x, self.y,
        0,
        self.width / self.image:getWidth(),
        self.height / self.image:getHeight()
      )

      love.graphics.setColor(1, 1, 1)
      love.graphics.printf(
        self.text,
        self.font,
        self.x - 40,
        self.y + self.height + 55,
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

  for i = 1, #self.isHovered do
    self:_drawPlayerStatus(i, self.isHovered[i], self.isSelected[i])
  end
end

function Button:_drawPlayerStatus(playerIndex, isHovered, isSelected)
  if not (isHovered or isSelected) then return end

  local x, y
  local c = {}
  local opacity
  
  if playerIndex == 1 then
    c[1] = 0.8; c[2] = 0.45; c[3] = 0.8
  elseif playerIndex == 2 then
    c[1] = 0.8; c[2] = 0.8; c[3] = 0.3
  elseif playerIndex == 3 then
    c[1] = 0.4; c[2] = 0.6; c[3] = 0.9
  elseif playerIndex == 4 then
    c[1] = 0.5; c[2] = 0.8; c[3] = 0.5
  end

  if isHovered then
    x = self.x + self.playerStatusHoveredPosOffsets[playerIndex].x
    y = self.y + self.playerStatusHoveredPosOffsets[playerIndex].y
    opacity = 0.5
  elseif isSelected then
    x = self.x + self.playerStatusLockedPosOffsets[playerIndex].x
    y = self.y + self.playerStatusLockedPosOffsets[playerIndex].y
    opacity = 1
  end
  c[4] = opacity

  love.graphics.setColor(0.7, 0.7, 0.7, 0.1)
  love.graphics.circle('fill', x, y, 35)

  love.graphics.setColor(c)
  love.graphics.setLineWidth(9)
  love.graphics.circle('line', x, y, 30)
  love.graphics.setLineWidth(1)

  love.graphics.setColor(c)
  local text = 'P'..tostring(playerIndex)
  love.graphics.setColor(c)
  love.graphics.setFont(Fonts.small)
  love.graphics.print(text, x, y, 0, 1, 1,
      Fonts.small:getWidth(text) / 2, Fonts.small:getHeight() / 2)
end

return Button