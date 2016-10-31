local class = require 'ext.middleclass'

local Sprite = class('Sprite')

function Sprite:initialize(image)
    self.image    = image
    self.position = vec(250, 250)
    local ix, iy  = self.image:getDimensions()
    self.origin   = vec(ix/2, iy/2)
    self.scale    = vec(1 ,1)
    self.rotation = 0
end

function Sprite:move(x, y)
    self.position = self.position + vec(x, y)
end

function Sprite:rotate(deg)
    self.rotation = self.rotation + deg2rad(deg)
end

function Sprite:draw()
    love.graphics.draw(self.image, self.position.x, self.position.y, self.rotation, self.scale.x, self.scale.y, self.origin.x, self.origin.y)
end

return Sprite
