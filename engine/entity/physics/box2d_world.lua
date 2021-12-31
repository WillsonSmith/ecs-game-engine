local windfield = require "lib/windfield/windfield"

function box2d(gravityX, gravityY)
  local world = windfield.newWorld(gravityX, gravityY, true)
  world:setGravity(gravityX, gravityY)
  return {
    box2d = true,
    gravity = {x = gravityX, y = gravityY},
    world = world
  }
end

return box2d