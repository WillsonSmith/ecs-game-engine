local tiny = require 'lib/tiny'
local Timer = require 'lib/hump/timer'
local hextocolor = require 'lib/hextocolor'

local lighting_environment = require 'engine.entity.lighting_environment'
local lamp = require 'engine.entity.lamp'

local lighting = {
  illumunator = nil
}
lighting.lights = tiny.processingSystem()
lighting.lights.filter = tiny.requireAll("light")
function lighting.lights:onAdd(light)
  if not lighting.illumunator then
    for _, entity in ipairs(self.world.entities) do
      if lighting.illumunator then break end
      local filter = tiny.requireAll("illumunator")

      if filter(self.world, entity) then
        lighting.illumunator = entity.illumunator
        break
      end
    end
    
    local environment = lighting_environment()
    lighting.illumunator = environment.illumunator
    tiny.addEntity(self.world, environment)
  end

  local color = light.light.color
  local r = color.r
  local g = color.g
  local b = color.b
  local a = color.a or 1
  local illumunator_light = lighting.illumunator:addLight(
    light.position.x,
    light.position.y,
    light.light.radius,
    r, g, b, a
  )
  light.light.light = illumunator_light
end

function lighting.lights:onRemove(light)
  if lighting.illumunator then lighting.illumunator:removeLight(light.light.light) end
end

function lighting.lights:process(e, dt)
  if not e.on_screen then return end
  if e.needs_update then
    local light = e.light
    lighting.illumunator:updateLight(
      light.light,
      light.position.x,
      light.position.y,
      light.radius,
      light.color.r,
      light.color.g,
      light.color.b,
      light.color.a
    )
    e.needs_update = false
  end
  
  if e.flicker then
    local r = e.light.color.r
    local g = e.light.color.g
    local b = e.light.color.b
    local a = e.light.color.a

    if not e.light.tweening then
      e.light.tweening = true
      Timer.script(function(wait)
        local alpha = a
        Timer.tween(
          0.5,
          e.light.color, 
          {r = r, g = g, b = b, a = alpha * -1}, 
          'out-elastic'
        )
        wait(0.2)

        Timer.tween(
          0.5,
          e.light.color, 
          {r = r, g = g, b = b, a = alpha}, 
          'out-elastic'
        )
        wait(5)
        e.light.tweening = false
      end)
    end
  end

  local light = e.light
  local ex, ey = e.position.x, e.position.y
  local lx, ly = light.position.x, light.position.y
  if ex ~= lx or ey ~= ly then
    e.needs_update = true
  end
  
  local lightRadius = e.light.radius
  if light.radius ~= lightRadius then
    e.needs_update = true
  end

  if light.color.r ~= light.light.r 
    or light.color.g ~= light.light.g 
    or light.color.b ~= light.light.b 
    or light.color.a ~= light.light.a then
      e.needs_update = true
  end
end

lighting.draw = tiny.processingSystem()
lighting.draw.filter = tiny.requireAll("illumunator")
function lighting.draw:onRemoveFromWorld()
  lighting.illumunator = nil
end

function lighting.draw:onAdd(e)
  if not lighting.map then
    for _, e in ipairs(self.world.entities) do
      if lighting.map then break end
      local filter = tiny.requireAll("map")
      if filter(self.world, e) then
        lighting.map = e
        break
      end
    end
  end

  if lighting.map then 
    for _, object in pairs(lighting.map.map.layers["walls"].objects) do
      local x, y = object.x, object.y 
      local width, height = object.width, object.height
      local x1, y1 = x, y
      local x2, y2 = x + width, y
      local x3, y3 = x + width, y + height
      local x4, y4 = x, y + height
      local wall = {x1, y1, x2, y2, x3, y3, x4, y4}
      e.illumunator:addPolygon(wall)
    end
  end
end

function lighting.draw:process(e, dt)
  e.illumunator:drawLights()
end

lighting.from_map = tiny.processingSystem()
lighting.from_map.filter = tiny.requireAll('map')
function lighting.from_map:onAdd(map)
  local lights = map.map.layers["lights"]
  if not lights then return end

  for _, object in pairs(lights.objects) do
    local x = object.x or 0
    local y = object.y or 0
    local color = {255, 255, 255}
    local radius = 100
    local flicker = false

    if object.properties.flicker then
      flicker = true
    end
    if object.properties.radius then
      radius = object.properties.radius
    end
    if object.properties.color then
      color = hextocolor(object.properties.color)
    end

    tiny.addEntity(
      self.world,
      lamp({
        x = x,
        y = y, 
        color = color, 
        radius = radius,
        flicker = flicker,
        on_screen = true
      })
    )
  end
end

return lighting