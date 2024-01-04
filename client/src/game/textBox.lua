local TextBox = Class('TextBox')

local IMAGES = {
  Images.ui.textBoxes.gem,
  Images.ui.textBoxes.sponge,
  Images.ui.textBoxes.green,
  Images.ui.textBoxes.ice,
}

local SW, SH = 0.17, 0.125


--split the string to chars in setNewWord
function splitString(str)
  local chars = {}
  for i = 1, #str do
      local char = str:sub(i, i)
      table.insert(chars, char)
  end
  return chars
end

function TextBox:initialize(playerIndex, x, y)
  self.playerIndex = playerIndex
  self.x, self.y = x, y
  self.currentCharacters = {"d","o","g"}
  self.typedCharacters = {}
  self.characterIndex = 1
end

function TextBox:setNewWord(word)
  --setNewWord from word to list
  self.currentCharacters = splitString(word)
  self.typedCharacters = {}
  self.characterIndex = 1
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
  love.graphics.printf(self.typedCharacters,
      self.x - IMAGES[self.playerIndex]:getWidth() / 2 * SW, self.y + 50,
      IMAGES[self.playerIndex]:getWidth() * SW, 'center', 0, 1, 1)
end

function TextBox:keypressed(key, scancode, isRepeat)
  if self.characterIndex <= #self.currentCharacters then
    local nextChar = self.currentCharacters[self.characterIndex]
    if key == nextChar then
        table.insert(self.typedCharacters, key)
        self.characterIndex = self.characterIndex + 1
    end

    -- Check if the word is completely typed
    if #self.currentCharacters == #self.typedCharacters then
      self:setNewWord("cat")
    end
  end
end

return TextBox