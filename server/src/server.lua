local Server = Sock.newServer('*', 22122)

Server:setSerialization(bitser.dumps, bitser.loads)

Server:on('connect', function(data, client)
  print('helo')
  local msg = 'Hello from the server!'
  client:send('hello', msg)
end)

Server:on('disconnect', function(data)
    print('Client disconnected to the server')
end)

return Server