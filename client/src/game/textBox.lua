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

  self.currentCharacters = {'d', 'o', 'g'}
  self.typedCharacters = {'d'}
end

function TextBox:setNewWord(word)
  -- convert string to array of string
end

function TextBox:update(dt)
  
end

function TextBox:draw()
  love.graphics.setColor(1, 1, 1)
  love.graphics.draw(IMAGES[self.playerIndex], self.x, self.y, 0, SW, SH,
      IMAGES[self.playerIndex]:getWidth() / 2, IMAGES[self.playerIndex]:getHeight() / 2)

  love.graphics.setColor(1, 1, 1)
  love.graphics.setFont(Fonts.medium)
  love.graphics.printf(self.currentCharacters,
      self.x - IMAGES[self.playerIndex]:getWidth() / 2 * SW, self.y - 20,
      IMAGES[self.playerIndex]:getWidth() * SW, 'center', 0, 1, 1)
end

function TextBox:keypressed(key, scancode, isRepeat)
  -- add key to typed characters if right key
end

return TextBox