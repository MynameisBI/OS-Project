local Client = Sock.newClient('localhost', 1905)

Client:setSerialization(bitser.dumps, bitser.loads)

Client:on('connect', function(data)
  print('Client connected to the server')
  Gamestate.registerEvents()
  Gamestate.switch(Menu)
end)

Client:on('disconnect', function(data)
  print('Client disconnected to the server')
end)

Client:on('hello', function(msg)
  print('The server replied: ' .. msg)
end)

return Client