local class = require 'ext.middleclass'

local Sprite = class('Sprite')

function Sprite:initialize(image)
    self.image              = image
    self.position           = vec(0, 0)
    self.width, self.height = self.image:getDimensions()
    self.origin             = vec(self.width/2, self.height/2)
    self.scale              = vec(1 ,1)
    self.rotation           = -(math.pi/2)
    self.velocity           = vec(0, 0)
    self.acceleration       = vec(0, 0)

    self.thrust = 0
    self.maxspeed = 0
    self.friction = 1
end

function Sprite:accelerate(speed)
    dir = rad2vec(self.rotation) * speed
    self.acceleration = self.acceleration + dir
end

function Sprite:applyForce(force)
    self.acceleration = self.acceleration + force
end

function Sprite:move(x, y)
    self.position = self.position + vec(x, y)
end

function Sprite:rotate(deg)
    self.rotation = self.rotation + deg2rad(deg)
end

function Sprite:setScale(sc)
    self.scale = vec(sc, sc)
end

function Sprite:update(dt)
    self.velocity = self.velocity + self.acceleration
    self.position = self.position + self.velocity
    self.velocity = self.velocity / self.friction -- friction
    self.acceleration = vec(0, 0) 
    self.velocity:trimInplace(self.maxspeed)
end

function Sprite:draw()
    love.graphics.draw(self.image, 
                       self.position.x, 
                       self.position.y, 
                       self.rotation + (math.pi/2), 
                       self.scale.x, 
                       self.scale.y, 
                       self.origin.x, 
                       self.origin.y)
end

return Sprite
