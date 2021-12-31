local tiny = require "lib/tiny"
local Timer = require "lib/hump/timer"

local box2d_world = require "engine/entity/physics/box2d"
local box2d_colliders = require "engine/system/collision/box2d"
-- local entity_tiledMap = require "engine/entity/tiled_map"
-- local system_mapBox2dCollision = require "engine/system/map/collision/box2d"
-- local system_drawMap = require "engine/system/map/draw"
local debug = {}
debug.draw = {}
debug.draw.box2d_world = require "engine/system/debug/collision/box2d"


local game = {
  fullscreen = false,
  vsync = true,
  msaa = 0
}
function love.load()
  love.graphics.setDefaultFilter("nearest", "nearest")
  love.window.setMode(800, 600, game)
  love.window.setTitle("ECS Game Engine")

  game.world = tiny.world(
    box2d_world(0, 9.8),
    {
      x = 10,
      y = 10,
      width = 100,
      height = 100,
      collision = {
        shape = "rectangle"
      }
    },
    -- entity_tiledMap({
    --   map_file = "assets/maps/map.lua",
    --   drawing_layers = {
    --     "background",
    --     "foreground"
    --   },
    --   collision_layer = "collision"
    -- }),
    -- system_mapBox2dCollision,
    -- system_drawMap,
    -- debug_system_drawBox2dWorld,
    debug.draw.box2d_world,
    box2d_colliders.init,
    box2d_colliders.update
    -- box2d_colliders.debug.draw
  )

  game.world:update(0)
end

function love.update(dt)
  Timer.update(dt)
  game.world:update(dt)
end

function love.draw()
  -- box2d_colliders.debug.draw(love.timer.getDelta())
  -- system_drawMap:update(love.timer.getDelta())
  -- debug_system_drawBox2dWorld:update(love.timer.getDelta())
  debug.draw.box2d_world:update(love.timer.getDelta())
end