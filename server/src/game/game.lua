--Tao gamestate trong khong
-- 1 table co 4 arrays images, images[4] -> access image at id 4
--- position[x, y], direction[x,y], speed(optional) => each thread is used to compute this
--- position.x = dir.x + speed

--- What will have: 
--- What should be done: return imageId with the new location to to clients, also where they already type -> 2 arrays: 1 what should be type, 1 what already typed
--- with one character got typed one image will be spawned