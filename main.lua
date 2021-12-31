if pcall(require, "lldebugger") then
  require("lldebugger").start()
end

--love.graphics.setDefaultFilter("nearest")
io.stdout:setvbuf('no')
love.window.maximize(false)
math.randomseed(os.time())
isDebug = false

local game = nil

Locator = nil

----------
-- load --
----------
function love.load()
  Locator = require('Core/Libraries/Service_Locator').new()
  game    = require('Game/Default_Game').new("New_Game")
  game:Load()
end

------------
-- update --
------------
function love.update(dt)
  --if(isDebug) then
    if(love.keyboard.isDown("escape")) then love.event.quit() end
  --end
  game:Update(dt)
end

----------
-- draw --
----------
function love.draw()
  game:Draw()
  if(isDebug) then love.graphics.print(tostring(love.timer.getFPS(), 10, 10)) end
end