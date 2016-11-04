-- libraries
Gamestate = require 'ext.hump.gamestate'
Timer     = require 'ext.hump.timer'
Log       = require 'ext.log'
Camera    = require 'ext.hump.camera'
Assets    = require('ext.cargo').init('assets')
HC        = require 'ext.HC'
vec       = require 'ext.hump.vector'

Player    = require 'player'
Ghost     = require 'ghost'

require 'libs.maths.helpers'

bughunt = true

-- input
baton = require 'ext.baton'
Input = baton.new({
    rotleft  = {'key:left', 'key:a'},
    rotright = {'key:right', 'key:d'},
    forwards = {'key:up', 'key:w'},
    reverse  = {'key:down', 'key:s'},
    fire     = {'key:space'},

    escape   = {'key:escape'},
    bughunt  = {'key:0'}
})

-- states
require 'states.splash'
require 'states.mainmenu'
require 'states.game'

-- love
function love.load(args)
    love.mouse.setVisible(false)
    Gamestate.registerEvents()
    Gamestate.switch(game)
end

function love.update(dt)
    Input:update()
    Timer.update(dt)
end

function love.draw()
end
