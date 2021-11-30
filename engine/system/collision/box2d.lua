local tiny = require 'lib/tiny'

local collision_system = {}
collision_system.colliders = tiny.processingSystem()
collision_system.colliders.filter = tiny.requireAll('collision')
function collision_system.colliders:onAdd(e)
end
