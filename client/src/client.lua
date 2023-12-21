local Client = Sock.newClient('localhost', 22122)

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

---Rumis implemented sample accept callback
Client:on('accept', function()
  Gamestate.registerEvents()
  Gamestate.switch(Menu)
end)

Client:on('updateMenu', function(options)
end)

return Client