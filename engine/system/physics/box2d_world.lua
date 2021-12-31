local tiny = require 'lib/tiny'
local windfield = require 'lib/windfield/windfield'

local box2d_world = {}
box2d_world.init = tiny.processingSystem()
box2d_world.init.filter = tiny.requireAll('box2d', 'world')
function box2d_world.init:onAdd(e, dt)
end
function box2d_world.init:process(e, dt)
  e.world:update(dt)
end

return box2d_world