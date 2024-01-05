local Load = {}

function Load:enter(from, gameNumber)
  self.clientStatuses = {}
  for i = 1, Server:getClientCount() do
    self.clientStatuses[i] = {}
    self.clientStatuses[i] = 'loading'
  end

  self.gameNumber = gameNumber
end

return Load