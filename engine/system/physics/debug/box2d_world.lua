local tiny = require 'lib/tiny'

local draw = tiny.processingSystem()
draw.filter = tiny.requireAll('box2d', 'world')
function draw:process(e, dt)
  e.world:draw()
end

return draw