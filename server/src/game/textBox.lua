local TextBox = Class('TextBox')

function TextBox:initialize()
  self.playerIndex = playerIndex
  self.currentCharacters = {}
  self.typedCharacters = {}
  self.characterIndex = 1

  self.currentWordIndex = 0

  self.score = 0

  self:setNewWord()
end

function TextBox:setNewWord()
  --setNewWord from word to list
  self.currentWordIndex = self.currentWordIndex + 1
  local word = Gamestate.current().words[self.currentWordIndex]

  if word == nil then
    print('Some one win')
  end

  self.currentCharacters = self:splitString(word)
  self.typedCharacters = {}
  self.characterIndex = 1

  for i = 1, #self.currentCharacters do
    print(("%s"):format(self.currentCharacters[i]))
  end
  print()
end

function TextBox:splitString(str)
  local chars = {}
  for i = 1, #str do
      local char = str:sub(i, i)
      table.insert(chars, char)
  end
  return chars
end

function TextBox:keypressed(key)
  if self.characterIndex <= #self.currentCharacters then
    local nextChar = self.currentCharacters[self.characterIndex]

    if (key == 'space' and ' ' == nextChar) or key == nextChar then
      table.insert(self.typedCharacters, nextChar)
      self.characterIndex = self.characterIndex + 1

      if #self.currentCharacters == #self.typedCharacters then
        self.score = self.score + 1
        self:setNewWord()
      end
    end
  end
end

return TextBox