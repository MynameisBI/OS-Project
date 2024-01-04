local Client = Sock.newClient('localhost', 22122)

Client:setSerialization(bitser.dumps, bitser.loads)

Client:on('connect', function(data)
  print('Client connected to the server')
  Gamestate.registerEvents()
  Gamestate.switch(Menu)
end)

Client:on('accept', function(id)
  Client.clientId = id
end)

Client:on('deny', function()
  print('Can\'t connect to the server')
end)

Client:on('disconnect', function(data)
  print('Client disconnected to the server')
end)


Client:on('switchMenu', function()
  Gamestate.switch(Menu)
end)

Client:on('updateMenu', function(options)
  --Retrieve serverResponse here
  -- local serverResponses = {
  --   { hoveredClients = {true, true, true, true}, lockedClients = {false, false, false, false} },
  --   { hoveredClients = {false, false, false, false}, lockedClients = {true, true, true, true} },
  --   { hoveredClients = {true, true, false, false}, lockedClients = {false, false, true, true} },
  --   { hoveredClients = {false, false, true, true}, lockedClients = {true, true, false, false} }
  -- }

  local buttons = Gamestate.current().buttons
  for i = 1, 3 do 
    buttons[i]:update(love.timer.getDelta(), options[i].hoveredClients, options[i].lockedClients)
  end
  -- for i, button in ipairs(Gamestate.current().buttons) do
  --   button:update(dt, serverResponses[i].hoveredClients, serverResponses[i].lockedClients)
  -- end
end)


Client:on('switchLoad', function(gameNumber)
  Gamestate.switch(Load, {gameNumber = gameNumber})
end)

Client:on('updateLoad', function(options)
  
end)

Client:on('updateGame', function(imageData)
  Game.imageData = imageData
end)

function Client:draw()

end

return Client