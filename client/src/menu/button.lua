local Button = Class('Button')

local MARGIN = 25

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
  if type(isHovered) == "table" then
    self.isHovered = isHovered
end

if type(isSelected) == "table" then
    self.isSelected = isSelected
end
end

function Button:draw()

love.graphics.setColor(1, 1, 1)

for i, player in ipairs(self.isHovered) do
  local isHovered = self.isHovered[i]
  local isSelected = self.isSelected[i]

  if isHovered or isSelected then
    local label = isSelected and 's' or 'h'

    if isSelected then
      love.graphics.setColor(0, 1, 0)
    end
--set font size todo
    if i == 1 then
      love.graphics.printf(tostring(i) .. " " .. label, self.x - MARGIN, self.y - MARGIN, self.width, 'left')
    elseif i == 2 then
      love.graphics.printf(tostring(i) .. " " .. label, self.x + MARGIN, self.y - MARGIN, self.width, 'right')
    elseif i == 3 then
      love.graphics.printf(tostring(i) .. " " .. label, self.x + MARGIN, self.y + self.height + MARGIN, self.width, 'right')
    elseif i == 4 then
      love.graphics.printf(tostring(i) .. " " .. label, self.x - MARGIN, self.y + self.height + MARGIN, self.width, 'left')
    end

    
    love.graphics.setColor(1, 1, 1)
  end
end

--second implementation: with separate function
--drawItems(self.isHovered, 'h', self.x, self.y, self.width, self.height, MARGIN)
--drawItems(self.isSelected, 's', self.x, self.y, self.width, self.height, MARGIN)
--do i need for loop and if selfisHovered[i] and selfisSelected[i] then error?
--(if they have same value which cant happen)
--logic to draw just one text for selected or hovered
-- (even needed? because it can only have one state if value calculated correctly)
-- implement so it draws them at the corners


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

--separate function (maybe not needed)
function drawItems(items, label, x, y, width, height, margin)
  for i, player in ipairs(items) do
    if items[i] then
      if i == 1 then
        love.graphics.printf(tostring(i) .. " " .. label, x - margin, y - margin, width, 'left')
        love.graphics.circle('line',x - margin, y - margin, 10)
      elseif i == 2 then
        love.graphics.printf(tostring(i) .. " " .. label, x + margin, y - margin, width, 'right')
      elseif i == 3 then
        love.graphics.printf(tostring(i) .. " " .. label, x + margin, y + height + margin, width, 'right')
      elseif i == 4 then
        love.graphics.printf(tostring(i) .. " " .. label, x - margin, y + height + margin, width, 'left')
      end
    end
  end
end

return Button