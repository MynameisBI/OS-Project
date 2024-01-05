local Load = {}

function Load:enter(from, gameTheme)
  self.clientStatuses = {}
  for i = 1, Server:getClientCount() do
    self.clientStatuses[i] = {}
    self.clientStatuses[i] = 'loading'
  end

  self.gameTheme = gameTheme
end

return Load