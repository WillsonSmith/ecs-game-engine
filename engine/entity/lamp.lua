local position = require("engine/component/position")

function lamp(options)
  local x = options.x or 0
  local y = options.y or 0
  local color = options.color or {255, 255, 255}
  local radius = options.radius or 100
  local flicker = options.flicker or false
  local on_screen = options.on_screen or false

  return {
    on_screen = on_screen,
    flicker = flicker,
    needs_update = true,
    position = position(x, y),
    light = {
      color = {
        r = color[1],
        g = color[2],
        b = color[3],
        a = color[4] or 1
      },
      position = position(x, y),
      radius = radius
    }
  }
end

return lamp