love.graphics.setDefaultFilter("nearest")
io.stdout:setvbuf('no')
love.window.maximize(false)
math.randomseed(os.time())
GAME_NAME = "my new game"

local game = nil

----------
-- load --
----------
function love.load()
  game = require('Games/Default_Game').new("New_Game")
  game:Load()
end

------------
-- update --
------------
function love.update(dt)
  if(debug) then
    if(love.keyboard.isDown("escape")) then love.event.quit() end
  end
  game:Update(dt)
end

----------
-- draw --
----------
function love.draw()
  game:Draw()
  if(debug) then love.graphics.print(tostring(love.timer.getFPS(), 10, 10)) end
end