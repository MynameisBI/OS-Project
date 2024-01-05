local TextBox = Class('TextBox')

local IMAGES = {
  Images.ui.textBoxes.gem,
  Images.ui.textBoxes.sponge,
  Images.ui.textBoxes.green,
  Images.ui.textBoxes.ice,
}

local SW, SH = 0.17, 0.125

function TextBox:initialize(playerIndex, x, y)
  self.playerIndex = playerIndex

  self.x, self.y = x, y
  self.currentCharacters = {}
  self.typedCharacters = {}
  self.characterIndex = 1
end

function TextBox:update(dt)
  
end

function TextBox:draw()
  love.graphics.setColor(1, 1, 1)
  love.graphics.draw(IMAGES[self.playerIndex], self.x, self.y, 0, SW, SH,
      IMAGES[self.playerIndex]:getWidth() / 2, IMAGES[self.playerIndex]:getHeight() / 2)

  love.graphics.setColor(0.2, 0.2, 0.2, 0.6)
  love.graphics.setFont(Fonts.medium)
  love.graphics.print(self.currentCharacters,
      self.x - Fonts.medium:getWidth(self:getCurrentWord()) / 2,
      self.y - Fonts.medium:getHeight() / 2, 0, 1, 1)

  love.graphics.setColor(1, 1, 1)
  love.graphics.print(self.typedCharacters,
      self.x - Fonts.medium:getWidth(self:getCurrentWord()) / 2,
      self.y - Fonts.medium:getHeight() / 2, 0, 1, 1)
end

function TextBox:getCurrentWord()
  local w = ''
  for i = 1, #self.currentCharacters do
    w = w..self.currentCharacters[i]
  end
  return w
end

return TextBox