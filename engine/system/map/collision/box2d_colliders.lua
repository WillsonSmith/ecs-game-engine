local tiny = require "lib/tiny"

local collision = tiny.processingSystem()
collision.filter = tiny.requireAll("map", "collision_layer")
function collision:onAdd(e)
  local world
  for _, e in ipairs(self.world.entities) do
    if world then break end
    local filter = tiny.requireAll("box2d", "world")
    if filter(self.world, e) then
      world = e.world
      break
    end
  end

  for _, collider in ipairs(e.map_collision) do
    local shape = collider.shape
    local box2d_collider
    if shape == "polygon" then
      box2d_collider = world:newPolygonCollider(collider.points)
    end
    if shape == "rectangle" then
      box2d_collider = world:newRectangleCollider(collider.x, collider.y, collider.width, collider.height)
    end
    if shape == "ellipse" then
      print("ellipse not implemented")
    end

    if box2d_collider then
      box2d_collider:setType('static')
    end
  end
end

return collision