local sti = require "lib/sti/sti"

--[[
  tiled_map({
    map_file = "assets/maps/map.lua",
    drawing_layers = {
      "background",
      "foreground"
    },
    collision_layer = "collision"
  }),
]]--

local function tiled_map(options)
  local options = options or {}
  local tile_width = options.tile_width or 32
  local tile_height = options.tile_height or 32
  local map_file = options.map_file or "assets/maps/map.lua"
  local layers = options.layers or {}
  local collision_layer = options.collision_layer or nil
  local drawing_layers = options.drawing_layers or {}
  local map_collision = {}
  local map = sti(map_file)

  if collision_layer then
    local mapCollisionObjects = map.layers[collision_layer].objects
    for _, object in pairs(mapCollisionObjects) do
      local collision_shape = {
        x = object.x,
        y = object.y,
      }
      if object.shape == "polygon" then
        local polygon = object.polygon
        collision_shape.shape = "polygon"
        collision_shape.points = {}
        for _, object in ipairs(polygon) do
          table.insert(collision_shape.points, object.x)
          table.insert(collision_shape.points, object.y)
        end
      end

      if object.shape == "rectangle" then
        collision_shape.shape = "rectangle"
        collision_shape.width = object.width
        collision_shape.height = object.height
      end

      if object.shape == "ellipse" then
        print("ellipse collision not implemented")
      end

      table.insert(map_collision, collision_shape)
    end
  end

  return {
    tile_width = tile_width,
    tile_height = tile_height,
    map_file = map_file,
    layers = layers,
    collision_layer = collision_layer,
    drawing_layers = drawing_layers,
    map = map,
    map_collision = map_collision,
  }
end

return tiled_map