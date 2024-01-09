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
  local buttons = Gamestate.current().buttons
  for i = 1, 3 do 
    buttons[i]:update(love.timer.getDelta(), options[i].hoveredClients, options[i].lockedClients)
  end
end)


Client:on('switchLoad', function(gameTheme)
  Gamestate.switch(Load, gameTheme)
end)

Client:on('updateLoad', function(options)
  
end)


Client:on('switchGame', function()
  local loadState = Gamestate.current()
  Gamestate.switch(Game, loadState.gameTheme, loadState.images)
end)

Client:on('updateGame', function(state)
  local game = Gamestate.current()

  for i = 1, 4 do
    game.textBoxes[i].currentCharacters = state.textBoxes[i].currentCharacters
    game.textBoxes[i].typedCharacters = state.textBoxes[i].typedCharacters
    game.textBoxes[i].score = state.textBoxes[i].score
  end

  game.imageDatas = state.imageDatas
end)

Client:on('playerWin', function(playerIndex)
  local game = Gamestate.current()

  game:onPlayerWin(playerIndex)
end)

return Client