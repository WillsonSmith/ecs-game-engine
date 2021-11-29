# ECS Game Engine
a Lua based game engine for Löve2D

### How to use

`main.lua`

```lua
local tiny = require 'lib/tiny'
local lamp = require 'engine/entity/lamp'
local lighting = require 'engine/system/lighting'

local game = {
  fullscreen = false,
  vsync = true,
  msaa = 0
}
function love.load()
  love.graphics.setDefaultFilter("nearest", "nearest")
  love.window.setMode(800, 600, game)
  love.window.setTitle("ECS Game Engine")

  game.world = tiny.world(
    lamp({
      x = love.graphics:getWidth() / 2,
      y = love.graphics:getHeight() / 2,
      color = {255, 255, 255},
      on_screen = true,
    }),
    lighting.from_map,
    lighting.lights,
    lighting.draw
  )

  game.world:update(0)
end

function love.update(dt)
  game.world:update(dt)
end

function love.draw()
  lighting.draw:update(love.timer.getDelta())
end
```

---

> MIT License

Copyright (c) 2021 Willson Smith

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
