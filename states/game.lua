game = {}

worldx = 5000
worldy = 5000

ghosts = {}

function game:init()

    bg                             = Assets.images.background
    bg:setWrap('repeat', 'repeat')
    bgQuad                         = love.graphics.newQuad(0, 0, worldx, worldy, Assets.images.background:getDimensions())

    player                         = Player:new()
    player.position                = vec(worldx/2, worldy/2)

    camera                         = Camera(player.position:unpack())


    for i=1, 250 do
        Ghost:generate(math.random(1, worldx), math.random(1, worldy))
        table.insert(ghosts, ghost)
    end
end


function game:update(dt)
    if Input:pressed 'escape' then love.event.push('quit') end
    if Input:pressed 'bughunt' then bughunt = not bughunt end

    player:update(dt)

    for i, g in ipairs(ghosts) do 
        if (g.position:dist(player.position) < 350) then g.target = player.position else g.target = nil end
        g:update(dt) 
        if g.AABB:collidesWith(player.AABB) then table.remove(ghosts, i) end
    end

    camera:lookAt(player.position:unpack())
end

function game:draw()
    camera:attach()

    love.graphics.draw(bg, bgQuad, 0, 0)

    player:draw()

    for _, g in pairs(ghosts) do g:draw() end

    camera:detach()
end

