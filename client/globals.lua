Bitser = require 'libs.bitser'
Sock = require 'libs.sock'
Gamestate = require 'libs.gamestate'
Class = require 'libs.middleclass'
Lume = require 'libs.lume'

Images = {
  ui = {
    catButton = love.graphics.newImage('assets/ui/catButton.png'),
    dogButton = love.graphics.newImage('assets/ui/dogButton.png'),
    skeletonButton = love.graphics.newImage('assets/ui/skeletonButton.png'),
    emptyBar = love.graphics.newImage('assets/ui/emptyBar.png'),
    progress = love.graphics.newImage('assets/ui/progress.png')
  },
  cats = {},
  dogs = {},
  skeletons = {},
}

Fonts = {
  tiny = love.graphics.newFont('assets/Foo.ttf', 16),
  small = love.graphics.newFont('assets/Foo.ttf', 24),
  medium = love.graphics.newFont('assets/Foo.ttf', 32),
  big = love.graphics.newFont('assets/Foo.ttf', 48),
  large = love.graphics.newFont('assets/Foo.ttf', 60),
}