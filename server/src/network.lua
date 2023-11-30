local Network = Sock.newServer('*', 1905)

Network:setSerialization(bitser.dumps, bitser.loads)

Network:on('connect', function(data, client)
    local msg = 'Hello from the server!'
    client:send('hello', msg)
end)

-- Network:on('disconnect', function(data)
--     print('Client disconnected to the server')
-- end)

return Network