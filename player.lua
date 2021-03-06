local class = require 'ext/middleclass'
local Sprite = require 'libs.sprite'

local Player = class('Player', Sprite)

function Player:initialize()
    Sprite.initialize(self, Assets.images.ship)
    self.thrust = 15
    self.maxspeed = 12
    self.rotspeed = 90
    self.friction = 1.02
    self.AABB = HC.rectangle(0, 0, self.width, self.height)
end

function Player:input(dt)
    if Input:down 'forwards' then self:accelerate(self.thrust * dt) end
    if Input:down 'reverse'  then self.velocity = self.velocity / 1.1 end

    if Input:down 'rotleft'  then self:rotate(-self.rotspeed * dt) end
    if Input:down 'rotright' then self:rotate(self.rotspeed * dt) end
end

function Player:update(dt)
    self:input(dt)
    Sprite.update(self, dt)
    self.AABB:moveTo(self.position:unpack())
    self.AABB:setRotation(self.rotation)
end

function Player:draw()
    Sprite.draw(self)
    if bughunt then self:drawDebug() end
end

function Player:drawDebug()
    self.AABB:draw('line')
end

return Player
