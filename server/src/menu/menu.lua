local Menu = {}
local Option = require 'src.menu.option'


function Menu:enter()
    print('hi')
    self.options = {Option(), Option()}
    print(self.options)
end

function Menu:update(dt)
    Server:sendToAll("updateMenu", self.options)

end

function Menu:draw()

end



return Menu