local lighter = require "lib/lighter"

function lighting_environment()
  return {
    ambient = {0.1, 0.1, 0.1},
    diffuse = {0.8, 0.8, 0.8},
    illumunator = lighter()
  }
end

return lighting_environment