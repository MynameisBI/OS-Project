return function(animalType) --dog or cat
    local images = {}
        for player = 1, 4 do
            images[player] = {}
            for imageId = 1, 150 do
                local imagePath = string.format("client/assets/%s(%d)", animalType, imageNumber)
                images[player][imageId] = imagePath
            end
        end
    return images --images[1][1] -> imageId 1 of player 1
end