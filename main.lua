local tiny = require 'lib.tiny'
local lamp = require 'engine.entity.lamp'
local lighting = require 'engine.system.lighting'

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
    lamp({
      x = love.graphics:getWidth() / 2,
      y = love.graphics:getHeight() / 2,
      on_screen = true
    }),
    lighting.light_system,
    lighting.from_map,
    lighting.lights,
    lighting.draw
  )
  game.world:update(0)
end

function love.update(dt)
  game.world:update(dt)
end

function love.draw()
end