game = {}

worldx = 5000
worldy = 5000

ghosts = {}

function game:init()
    player                         = Player:new()
    player.position                = vec(worldx/2, worldy/2)
    bg                             = Assets.images.background
    bg:setWrap('repeat', 'repeat')
    bgQuad                         = love.graphics.newQuad(0, 0, worldx, worldy, Assets.images.background:getDimensions())
    camera                         = Camera(player.position:unpack())

    vWidth = love.graphics.getWidth() 
    vHeight = love.graphics:getHeight() 

    for i=1, 20 do
        ghost = Ghost:new(math.random(1, worldx), math.random(1, worldy))
        ghost.thrust = math.random(1, 20) / 10.0
        ghost:setScale(0.5)
        table.insert(ghosts, ghost)
    end
end


function game:update(dt)
    if Input:pressed 'escape' then Gamestate.switch(mainmenu) end

    player:update(dt)
    for _, g in pairs(ghosts) do g:update(dt) end

    vTop = player.position.y - (vHeight/ 2)
    vLeft = player.position.x - (vWidth / 2)

    camera:lookAt(player.position:unpack())

end

function game:draw()
    camera:attach()
    love.graphics.draw(bg, bgQuad, 0, 0)
    player:draw()
    for _, g in pairs(ghosts) do g:draw() end
    camera:detach()
end

