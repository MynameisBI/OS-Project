local Server = Sock.newServer('*', 22122)

Server:setSerialization(bitser.dumps, bitser.loads)

Server:on('connect', function(data, client)
  print('helo')
  local msg = 'Hello from the server, you are: '..Server:getClientCount()
  client:send('hello', msg)
end)

Server:on('disconnect', function(data)
    print('Client disconnected to the server')
end)

local findClientIndex = function(client)
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
        local index = findClientIndex(client)
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
        local index = findClientIndex(client)
        if(option.hoveredClients[index]) then
          option.hoveredClients[index] = false
          i = i + 1
          if(i > #Gamestate.current().options) then
            i = 1;
          end
          Gamestate.current().option[i].hoveredClients[index] = true
        end
      end  
    end
  end


  -- continue for space

  --- After all locked in

  Server:sendToAll('switch', 'load')

end)




-- Server:on('completeLoad', function(data, client)

-- end)

return Server