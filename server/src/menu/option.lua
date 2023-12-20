-- local Option = Class('Option')

-- function Option:initialize()
--     self.hoveredClients = {false, false, false, false}
--     self.lockedClients = {false, false , false, false}
-- end

-- return Option

return function() 
    return {
        hoveredClients = {false, false, false, false},
        lockedClients = {false, false , false, false}
    }
end