local tiny = require "lib/tiny"
local Timer = require "lib/hump/timer"

local entity_box2dWorld = require "engine/entity/physics/box2d"

local entity_tiledMap = require "engine/entity/tiled_map"
local system_mapBox2dCollision = require "engine/system/map/collision/box2d"
local system_drawMap = require "engine/system/map/draw"

local debug_system_drawBox2dWorld = require "engine/system/debug/collision/box2d"

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
    -- entity_box2dWorld(0, 9.8),
    entity_tiledMap({
      map_file = "assets/maps/map.lua",
      drawing_layers = {
        "background",
        "foreground"
      },
      collision_layer = "collision"
    }),
    system_mapBox2dCollision,
    system_drawMap,
    debug_system_drawBox2dWorld
  )

  game.world:update(0)
end

function love.update(dt)
  Timer.update(dt)
  game.world:update(dt)
end

function love.draw()
  system_drawMap:update(love.timer.getDelta())
  debug_system_drawBox2dWorld:update(love.timer.getDelta())
end