local class = require 'ext/middleclass'
local Sprite = require 'libs.sprite'

local Player = class('Player', Sprite)

function Player:initialize(image)
    Sprite.initialize(self, image)
    self.velocity = vec(0, 0)
    self.acceleration = vec(0, 0)

    self.thrust = 15
    self.maxspeed = 10
    self.rotspeed = 90
    self.friction = 1.04
end

function Player:input(dt)
    if Input:down 'forwards' then self:accelerate(self.thrust * dt) end
    if Input:down 'reverse'  then self.velocity = self.velocity / 1.1 end

    if Input:down 'rotleft'  then self:rotate(-self.rotspeed * dt) end
    if Input:down 'rotright' then self:rotate(self.rotspeed * dt) end
end

function Player:accelerate(speed)
    dir = rad2vec(self.rotation - (math.pi/2)) * speed
    self.acceleration = self.acceleration + dir
end

function Player:update(dt)
    self:input(dt)

    self.velocity = self.velocity + self.acceleration
    self.position = self.position + self.velocity
    self.velocity = self.velocity / self.friction -- friction
    self.acceleration = vec(0, 0) 
    self.velocity:trimInplace(self.maxspeed)
end

return Player
