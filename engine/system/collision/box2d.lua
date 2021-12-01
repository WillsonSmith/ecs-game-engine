local tiny = require 'lib/tiny'
local windfield = require 'lib/windfield/windfield'
local entity_box2dWorld = require "engine/entity/physics/box2d"

local collision_system = {}
collision_system.colliders = tiny.processingSystem()
collision_system.colliders.filter = tiny.requireAll('collision')
function collision_system.colliders:onAdd(e)
  local box2dWorld
  for _, e in ipairs(self.world.entities) do
    if box2dWorld then break end
    local filter = tiny.requireAll("box2d", "world")
    if filter(self.world, e) then
      box2dWorld = e
      break
    end
  end
  if not box2dWorld then
    local entity = entity_box2dWorld(0, 9.8, true)
    box2dWorld = entity.world
    tiny.addEntity(self.world, entity)
  end


end

function collision_system.colliders:onRemove(e)
end
