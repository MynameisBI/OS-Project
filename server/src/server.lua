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

-- Server:on('hoverOption', function(data, client)

-- end)

-- Server:on('toggleLock', function(data, client)
--     local clientId = client:getConnectId()
    
-- end)

-- Server:on('completeLoad', function(data, client)

-- end)

-- Server:on('pressLetter', function(data, client)

-- end)

-- Server:on('pressSpace'

-- end)
return Server