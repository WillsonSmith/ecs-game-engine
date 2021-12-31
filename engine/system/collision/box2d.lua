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

  box2d_colliders.world = world

  -- Create the collider
  local collider = e.collision
  
end

function box2d_colliders.generator:onRemove(e)
end
