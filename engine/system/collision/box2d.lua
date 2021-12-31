local tiny = require 'lib/tiny'
local windfield = require 'lib/windfield/windfield'
local box2d_world = require "engine/entity/physics/box2d"

local box2d_colliders = {}

box2d_colliders.generator = tiny.processingSystem()
box2d_colliders.generator.filter = tiny.requireAll("collision")

box2d_colliders.world = nil

function box2d_colliders.generator:onAdd(e)

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

  if not world then
    world = box2d_world()
    self.world:addEntity(world)
  end

  -- Create the collider
  local collider = e.collision
  local shape = collider.shape
  if shape == "polygon" then
    world:newPolygonCollider(collider.points)
  end

  for _, collider in ipairs(e.collision) do
    local shape = collider.shape

    if shape == "rectangle" then
      -- use the entity's x and y, and the width and height
      world:newRectangleCollider(e.x, e.y, e.width, e.height)
    end
    if shape == "polygon" then
      world:newPolygonCollider(collider.points)
    end
    if shape == "ellipse" then
      print("ellipse not implemented")
    end
  end

  -- Add the world to the box2d_colliders object
  box2d_colliders.world = world
end

function box2d_colliders.generator:onRemove(e)
end


box2d_colliders.update = tiny.processingSystem()
box2d_colliders.update.filter = tiny.requireAll("collision")
function box2d_colliders.update:process(e, dt)
  local collider = e.collision
  if collider.updates_position then
    local x, y = e.body:getPosition()
    e.x = x
    e.y = y
  end
end