local tiny = require "lib/tiny"

local draw = tiny.processingSystem()
draw.filter = tiny.requireAll("map", "drawing_layers")
function draw:onAdd(e)
end
function draw:process(e, dt)
  local map = e.map
  for _, layer in ipairs(e.drawing_layers) do
    map:drawLayer(map.layers[tostring(layer)])
  end
end

return draw