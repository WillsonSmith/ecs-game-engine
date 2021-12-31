local tiny = require "lib/tiny"
local Timer = require "lib/hump/timer"

local entity = {}
entity.box2d_world = require "engine/entity/physics/box2d_world"

local component = {}
local system = {}

system.box2d_world = require "engine/system/physics/box2d_world"
system.box2d_colliders = require "engine/system/collision/box2d_colliders"

-- Debug systems
system.debug = {}
system.debug.draw = {}
system.debug.draw.box2d_world = require "engine/system/physics/debug/box2d_world"

local game = {
  fullscreen = false,
  vsync = true,
  msaa = 0
}
function love.load()
  love.graphics.setDefaultFilter("nearest", "nearest")
  love.window.setMode(800, 600, game)
  love.window.setTitle("ECS Game Engine")

  local test_entities = {}
    table.insert(test_entities, entity.box2d_world(0, 9.8))
    table.insert(test_entities, {
      x = 10,
      y = 10,
      width = 100,
      height = 100,
      collision = {
        shape = "rectangle"
      }
    })
    table.insert(test_entities, {
      collision = {
        shape = "polygon",
        points = {150, 100, 200, 50, 250, 150},
      }
    })

  game.world = tiny.world(
    system.box2d_world,
    system.box2d_colliders.init,
    system.box2d_colliders.update,
    system.debug.draw.box2d_world,
    unpack(test_entities)
  )

  game.world:update(0)
end

function love.update(dt)
  Timer.update(dt)
  game.world:update(dt)
end

function love.draw()
  system.debug.draw.box2d_world:update(love.timer.getDelta())
end
