local tiny = require "lib/tiny"
local Timer = require "lib/hump/timer"

local entity = {}
entity.box2d_world = require "engine/entity/physics/box2d_world"

-- Tiled map
entity.map = require "engine/entity/map/tiled_map"

local component = {}
local system = {}

-- Tiled system
system.map = {}
system.map.collision = require "engine/system/map/collision/box2d_colliders"
system.map.draw = require "engine/system/map/draw"

-- Box2D system
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

  local meter = 16
  love.physics.setMeter(meter)

  local test_entities = {}
    table.insert(test_entities, entity.box2d_world(0, 9.8 * meter))
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
        static = true,
        shape = "polygon",
        points = {150, 100, 200, 50, 250, 150}
      }
    })

    table.insert(test_entities, entity.map({
      map_file = "assets/maps/map.lua",
      drawing_layers = {
        "background",
        "foreground"
      },
      collision_layer = "collision"
    }))

  game.world = tiny.world(
    system.box2d_world.init,
    system.box2d_colliders.init,
    system.box2d_colliders.update,
    system.debug.draw.box2d_world,
    system.map.collision,
    system.map.draw,
    unpack(test_entities)
  )

  game.world:update(0)
end

function love.update(dt)
  Timer.update(dt)
  game.world:update(dt)
end

function love.draw()
  local dt = love.timer.getDelta()
  system.map.draw:update(dt)
  system.debug.draw.box2d_world:update(dt)
end
