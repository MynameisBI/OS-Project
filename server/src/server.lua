local Server = Sock.newServer('localhost', 22122)
local Load = require 'src/load/load'

Server:setSerialization(bitser.dumps, bitser.loads)

Server:on('connect', function(data, client)
  print('helo')
  local msg = 'Hello from the server, you are: '..Server:getClientCount()
  client:send('hello', msg)
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

Server:on('keyPressed', function(keyPressed, client)
  print(keyPressed)

  if(Gamestate.current() == Menu) then

    if keyPressed == 'a' or keyPressed == 'left' then
      for i, option in ipairs(Gamestate.current().options) do -- 
        local index = Server.findClientIndex(client)
        if(option.hoveredClients[index]) then
          option.hoveredClients[index] = false 
          i = i - 1 --move from left most to right most
          if(i < 1) then
            i = #Gamestate.current().options --get length of all options
          end
          Gamestate.current().options[i].hoveredClients[index] = true
        end
      end

    elseif keyPressed == 'd' or keyPressed =='right' then
      for i, option in ipairs(Gamestate.current().options) do
        local index = Server.findClientIndex(client)
        if(option.hoveredClients[index]) then
          option.hoveredClients[index] = false
          i = i + 1
          if(i > #Gamestate.current().options) then
            i = 1;
          end
          Gamestate.current().options[i].hoveredClients[index] = true
        end
      end  
    end

  end
end)

function allClientsLocked()
  for i, option in ipairs(Gamestate.current().options) do
    for i, locked in ipairs(option.lockedClients) do
      if not locked then
        return false
      end
    end
  end
  return true
end

  -- continue for space
Server:on('keyPressed', function(keyPressed, client)
  if(Gamestate.current() == Menu) then
    if( keyPressed == 'space' or keyPressed == 'return') then
      for i, option in ipairs(Gamestate.current().options) do
        local index = Server.findClientIndex(client)
        if(option.lockedClients[index]) then
          Gamestate.current().options[i].lockedClients[index] = true
        else
          Gamestate.current().options[i].lockedClients[index] = flase
        end
      end

      --if all clients are locked
      if allClientsLocked() then
        Server:sendToAll('switch', 'load')
        Gamestate.switch(Load)
      end
    end  
  end
end)





-- Server:on('completeLoad', function(data, client)

-- end)

return Server