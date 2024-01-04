local Menu = {}
local Option = require 'src.menu.option'


function Menu:enter()
  print('hi')
  self.options = {Option(1), Option(2), Option(3)}
  print(self.options)
end

function Menu:update(dt)
  Server:sendToAll("updateMenu", self.options)
end

function Menu:draw()

end



return Menu