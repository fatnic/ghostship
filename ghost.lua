
local class = require 'ext/middleclass'
local Sprite = require 'libs.sprite'

local Ghost = class('Ghost', Sprite)

function Ghost:initialize(x, y)
    Sprite.initialize(self, Assets.images.ghost)
    self.position = vec(x, y)
end

function Ghost:update(dt)
    self.rotation = vec2rad(player.position - self.position)
    self:accelerate(self.thrust)
    Sprite.update(self, dt)
end

return Ghost
