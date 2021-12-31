local windfield = require "lib/windfield/windfield"

function box2d(gravityX, gravityY, collisionClasses)
  local world = windfield.newWorld(gravityX, gravityY, true)
  world:setGravity(gravityX, gravityY)

  if collisionClasses then
    for _, class in collisionClasses do
      world:addCollisionClass(class)
    end
  end

  return {
    box2d = true,
    gravity = {x = gravityX, y = gravityY},
    world = world
  }
end

return box2d