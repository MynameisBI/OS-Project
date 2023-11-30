local Network = Sock.newClient('localhost', 1905)

Network:setSerialization(bitser.dumps, bitser.loads)

Network:on('connect', function(data)
    print('Client connected to the server')
    Gamestate.registerEvents()
    Gamestate.switch(Menu)
end)

Network:on('disconnect', function(data)
    print('Client disconnected to the server')
end)

Network:on('hello', function(msg)
    print('The server replied: ' .. msg)
end)

return Network