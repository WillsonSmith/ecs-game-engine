local tiny = require 'lib/tiny'
local windfield = require 'lib/windfield/windfield'

local box2d_world = {}
box2d_world.init = tiny.processingSystem()
box2d_world.init.filter = tiny.requireAll('box2d', 'world')
function box2d_world.init:onAdd(e, dt)
  local world = box2d_world.world
  for _, e in ipairs(self.world.entities) do
    if world then break end
    local filter = tiny.requireAll('box2d', 'world')
    if filter(self.world, e) then
      world = e
      break
    end
  end
end

return box2d_world