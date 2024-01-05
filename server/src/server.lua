local Server = Sock.newServer('localhost', 22122)

Server:setSerialization(bitser.dumps, bitser.loads)

Server:on('connect', function(data, client)
  if Gamestate.current() ~= Menu or Server:getClientCount() >= 4 then 
    client:send('deny')
  end

  -- local msg = 'Hello from the server, you are: '..Server:getClientCount()
  client:send('accept', Server:getClientCount())

  Gamestate.current().options[1].hoveredClients[Server:getClientCount()] = true
end)

Server:on('disconnect', function(data)
    print('Client disconnected to the server')
end)

Server.findClientIndex = function(client)
  local clients = Server:getClients()
  for i = 1, Server:getClientCount() do 
    if clients[i] == client  then
      return i 
    end
  end
end

Server.getGameTheme = function(optionIndex)
  if optionIndex == 1 then
    return 'cat'
  elseif optionIndex == 2 then
    return 'dog'
  elseif optionIndex == 3 then
    return 'skeleton'
  end
end

Server:on('keyPressed', function(keyPressed, client)
  local clientIndex = Server.findClientIndex(client)

  print(('Client %d press %s'):format(clientIndex, keyPressed))

  if(Gamestate.current() == Menu) then
    local menu = Gamestate.current()

    if keyPressed == 'a' or keyPressed == 'left' then
      local optionIndex, status = getClientOption(clientIndex)
      if status == 'locked' then return end

      for i = 1, #menu.options do
        local option = menu.options[i]
        if (option.hoveredClients[clientIndex]) then
          option.hoveredClients[clientIndex] = false 
          i = i - 1 --move from left most to right most
          if(i < 1) then i = #menu.options end
          menu.options[i].hoveredClients[clientIndex] = true
          break
        end
      end
      
    elseif keyPressed == 'd' or keyPressed =='right' then
      local optionIndex, status = getClientOption(clientIndex)
      if status == 'locked' then return end

      for i = 1, #menu.options do
        local option = menu.options[i]
        if (option.hoveredClients[clientIndex]) then
          option.hoveredClients[clientIndex] = false 
          i = i + 1
          if(i > #menu.options) then i = 1 end
          menu.options[i].hoveredClients[clientIndex] = true
          break
        end
      end
    
    elseif (keyPressed == 'space' or keyPressed == 'return') then
      local optionIndex, status = getClientOption(clientIndex)

      -- print(('Client %d toggle option %d'):format(clientIndex, optionIndex))

      if status == 'hovered' then
        menu.options[optionIndex].hoveredClients[clientIndex] = false
        menu.options[optionIndex].lockedClients[clientIndex] = true

        if allClientsLockedOption(optionIndex) then
          Server:sendToAll('switchLoad', Server.getGameTheme(optionIndex))
          Gamestate.switch(Load, Server.getGameTheme(optionIndex))
        end

      elseif status == 'locked' then
        menu.options[optionIndex].lockedClients[clientIndex] = false
        menu.options[optionIndex].hoveredClients[clientIndex] = true
      end
    end  

  elseif Gamestate.current() == Game then
    local game = Gamestate.current()

    game.textBoxes[clientIndex]:keypressed(keyPressed)
    local clientId = Server.findClientIndex(client)
    game:spawn(keyPressed, clientIndex)

  end
end)

function getClientOption(clientIndex)
  local menu = Gamestate.current()
  assert(menu == Menu, 'Current gamestate is not Menu')

  for optionIndex = 1, #menu.options do
    local option = menu.options[optionIndex]
    if option.hoveredClients[clientIndex] then
      return optionIndex, 'hovered'
    elseif option.lockedClients[clientIndex] then
      return optionIndex, 'locked'
    end
  end
end

function allClientsLockedOption(optionIndex)
  local option = Gamestate.current().options[optionIndex]
  for i = 1, Server:getClientCount() do
    if not option.lockedClients[i] then
      return false
    end
  end
  return true 
end

Server:on('completeLoad', function(data, client)
  local loadState = Gamestate.current()
  if loadState ~= Load then
    print('Invalid completeLoad message from client. Current server gamestate is not Load')
  end

  local clientIndex = Server.findClientIndex(client)
  loadState.clientStatuses[clientIndex] = 'done'

  local allClientsDoneLoading = true
  for i = 1, Server:getClientCount() do
    if loadState.clientStatuses[i] == 'loading' then
      allClientsDoneLoading = false
    end
  end

  if allClientsDoneLoading then
    Gamestate.switch(Game, loadState.gameTheme)
    Server:sendToAll('switchGame')
  end
end)

return Server