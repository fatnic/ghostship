game = {}

worldx = 10000
worldy = 10000

function game:init()
    player                         = Player:new(Assets.images.ship)
    player.position                = vec(worldx/2, worldy/2)
    player.scale                   = vec(0.5, 0.5)

    bg                             = Assets.images.background
    bg:setWrap('repeat', 'repeat')
    bgQuad                         = love.graphics.newQuad(0, 0, worldx, worldy, Assets.images.background:getDimensions())

    camera                         = Camera(player.position:unpack())
end

function game:update(dt)
    if Input:pressed 'escape' then Gamestate.switch(mainmenu) end

    player:update(dt)
    camera:lookAt(player.position:unpack())
end

function game:draw()
    camera:attach()
    love.graphics.draw(bg, bgQuad, 0, 0)
    player:draw()
    camera:detach()
end

