local Load = {}

function Load:enter(from, gameNr)
  self.clientStatuses = {}
  for i = 1, Server:getClientCount() do
    self.clientStatuses[i] = {}
    self.clientStatuses[i] = 'loading'
  end
end

return Load