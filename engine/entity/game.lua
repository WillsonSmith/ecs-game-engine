local tiny = require "lib/tiny"

local game = {}
game.state = tiny.processingSystem()
game.state.filter = tiny.requireAll("game_state")
function game.state:onAdd(e)
  
end
function game.state:process(e, dt)
    if e.game_state == "menu" then
        e.menu:update(dt)
    elseif e.game_state == "game" then
        e.game:update(dt)
    elseif e.game_state == "pause" then
        e.pause:update(dt)
    elseif e.game_state == "gameover" then
        e.gameover:update(dt)
    end
end
function game.state:onRemove(e)
  
end