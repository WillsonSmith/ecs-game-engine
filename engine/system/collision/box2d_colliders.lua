local tiny = require 'lib/tiny'
local windfield = require 'lib/windfield/windfield'

local box2d_colliders = {}
box2d_colliders.init = tiny.processingSystem()
box2d_colliders.init.filter = tiny.requireAll("collision")

box2d_colliders.world = nil
function box2d_colliders.init:onAdd(e)
  -- Create the world if it doesn't exist
  local world = box2d_colliders.world
  for _, e in ipairs(self.world.entities) do
    if world then break end
    local filter = tiny.requireAll('box2d', 'world')
    if filter(self.world, e) then
      world = e
      break
    end
  end

  -- Create the collider
  local collider = e.collision
  local shape = collider.shape
  if shape == "rectangle" then
    e.collision.collider = world.world:newRectangleCollider(e.x, e.y, e.width, e.height)
  end
  if shape == "polygon" then
    e.collision.collider = world.world:newPolygonCollider(collider.points)
  end
  if shape == "ellipse" then
    print("ellipse not implemented")
  end

  if e.collision.static then
    e.collision.collider:setType('static')
  end

  -- Add the world to the box2d_colliders object
  box2d_colliders.world = world
end

function box2d_colliders.init:onRemove(e)
  if e.collision.collider then
    e.collision.collider:destroy()
  end
end


box2d_colliders.update = tiny.processingSystem()
box2d_colliders.update.filter = tiny.requireAll("collision")
function box2d_colliders.update:process(e, dt)
  local collider = e.collision

  -- update the collider's position
  if collider.updates_position then
    local x, y = e.body:getPosition()
    e.x = x
    e.y = y
  end
end

box2d_colliders.debug = {}
box2d_colliders.debug.draw = tiny.processingSystem()
box2d_colliders.debug.draw.filter = tiny.requireAll("collision")
function box2d_colliders.debug.draw:process(e, dt)
  local collider = e.collision
  local shape = collider.shape

  if shape == "rectangle" then
    love.graphics.rectangle("line", e.x, e.y, e.width, e.height)
  end
  if shape == "polygon" then
    love.graphics.polygon("line", collider.points)
  end
  if shape == "ellipse" then
    print("ellipse not implemented")
  end
end

return box2d_colliders