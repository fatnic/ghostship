local class = require 'ext/middleclass'

local Bullet = class('Bullet')

function Bullet:initialize(origin, velocity)
    self.image = Assets.images.laser
    self.position = origin
    self.velocity = velocity
    self.rotation = vec2rad(self.velocity) - (math.pi/2)
end

function Bullet:update(dt)
    self.position = self.position + self.velocity
end

function Bullet:draw()
    love.graphics.draw(self.image, self.position.x, self.position.y, self.rotation)
end

return Bullet
