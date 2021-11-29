# ECS Game Engine

## a Lua based game engine for Löve2D

### How to use

`main.lua`

```lua
  local tiny = require "engine/lib/tiny"
  local lighting = require "engine.system.lighting"
  local lamp = require "engine.entity.lamp"

  local game = {}
  function love.load()
    game.world = tiny.world(
      lamp({
        x = love.graphics.width / 2,
        y = love.graphics.height / 2
      }),
      lighting
    )
    game.world:update(0)
  end

  function love.update(dt)
    game.world:update(dt)
  end

  function love.draw()
  end
```
