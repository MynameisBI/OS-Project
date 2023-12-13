local TextBox = Class('TextBox')

function TextBox:initialize(playerIndex, x, y, width, height)
  self.playerIndex = playerIndex

  self.x, self.y, self.width, self.height = x, y, width, height

  self.currentCharacters = {'d', 'o', 'g'}
  self.typedCharacters = {'d'}
end

function TextBox:setNewWord(word)
  -- convert string to array of string
end

function TextBox:update(dt)
  
end

function TextBox:draw()
  love.graphics.setColor(0.3, 0.3, 0.3)
  love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)

  love.graphics.setColor(1, 1, 1)
  love.graphics.print(self.currentCharacters, self.x, self.y)
end

function TextBox:keypressed(key, scancode, isRepeat)
  -- add key to typed characters if right key
end

return TextBox