game = {}

function game:init()
    player          = Player:new(Assets.images.ship)
    sx, sy          = love.graphics.getDimensions()
    player.position = vec(sx/2, sy/2)
    player.scale    = vec(0.5, 0.5)
    bg              = Assets.images.background
    camera          = Camera(player.position:unpack())
end

function game:update(dt)
    if Input:pressed 'escape' then Gamestate.switch(mainmenu) end

    player:update(dt)
    camera:lookAt(player.position:unpack())
end

function game:draw()
    camera:attach()
    love.graphics.draw(bg, 0, 0)
    player:draw()
    camera:detach()
end

