-- local Option = Class('Option')

-- function Option:initialize()
--     self.hoveredClients = {false, false, false, false}
--     self.lockedClients = {false, false , false, false}
-- end

-- return Option
--- IMPORTANT
--- The game has 4 tables of this, eg:  A B C D
--- if player1 is in A then press 'd' then he move to table B, at index 2, hoverClients{f, t, f, f}
----
return function() 
    return {
        hoveredClients = {false, false, false, false},
        lockedClients = {false, false , false, false}
    }
end