local tiny = require "lib/tiny"
local entity_box2dWorld = require "engine/entity/physics/box2d"

local collision = tiny.processingSystem()
collision.filter = tiny.requireAll("map", "collision_layer")
function collision:onAdd(e)
  local box2dWorld
  for _, e in ipairs(self.world.entities) do
    if box2dWorld then break end
    local filter = tiny.requireAll("box2d", "world")
    if filter(self.world, e) then
      box2dWorld = e.world
      break
    end
  end
  if not box2dWorld then
    local entity = entity_box2dWorld(0, 9.8, true)
    box2dWorld = entity.world
    tiny.addEntity(self.world, entity)
  end

  for _, collider in ipairs(e.map_collision) do
    local shape = collider.shape
    if shape == "polygon" then
      box2dWorld:newPolygonCollider(collider.points)
    end
    if shape == "rectangle" then
      box2dWorld:newRectangleCollider(collider.x, collider.y, collider.width, collider.height)
    end
    if shape == "ellipse" then
      print("ellipse not implemented")
    end
  end
end

return collision