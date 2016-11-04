
local class = require 'ext/middleclass'
local Sprite = require 'libs.sprite'

local Ghost = class('Ghost', Sprite)

function Ghost:initialize(x, y)
    Sprite.initialize(self, Assets.images.ghost)
    self.position = vec(x, y)
    self.maxspeed = 4
    self.maxforce = 0.1
    self.target = nil
    self.AABB = HC.rectangle(0, 0, self.width, self.height)
end


function Ghost:seek(target)
    local desired = target - self.position
    desired:normalizeInplace()
    desired = desired * self.maxspeed

    local steer = desired - self.velocity
    steer:trimInplace(self.maxforce)
    self:applyForce(steer)
end

function Ghost:roam()
    local angle = math.random(0, (2 * math.pi) * 10) / 10.0
    local distance = math.random(0, 50)
    self:seek(vec(self.position.x + distance * math.cos(angle), self.position.y + distance * math.sin(angle)))
end

function Ghost:update(dt)
    if self.target ~= nil then self:seek(self.target) else self:roam() end
    self:checkBounds()
    self.rotation = vec2rad(self.velocity)
    Sprite.update(self, dt)
    self.AABB:moveTo(self.position:unpack())
    self.AABB:setRotation(self.rotation)
end

function Ghost:checkBounds()
end

function Ghost.static:generate(x, y)
    ghost = Ghost:new(x, y)
    ghost.rotation = math.random(1, 20) / 10.0
    ghost.maxspeed = 3
    ghost.maxforce = 0.05
end

function Ghost:draw()
    Sprite.draw(self)
    if bughunt then self:drawDebug() end
end

function Ghost:drawDebug()
    self.AABB:draw('line')
end

return Ghost
