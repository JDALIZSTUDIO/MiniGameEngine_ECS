love.graphics.setDefaultFilter("nearest")
io.stdout:setvbuf('no')
love.window.maximize(false)

math.randomseed(os.time())

GAME_NAME = "my new game"
tileSize     = 16

-- Window size
fullscreen   = false
screenScale  = 2
screenWidth  = 720
screenHeight = 360
windowWidth  = screenWidth  * screenScale
windowHeight = screenHeight * screenScale

-- ECS
p_Entity             = nil
p_Component          = nil
p_System             = nil

-- Classes
Resolution           = nil
Camera               = nil
Input                = nil
Helpers              = nil
StateMachine         = nil
SceneController      = nil
Timers               = nil
TransitionController = nil
Vector2              = nil

debug                = false
local surface, vignette

----------------
-- LoadScenes --
----------------
function LoadScenes()
  SceneController:Add("intro",      'Scenes/Scene_Intro')
  --SceneController:Add("title",      'Scenes/Scene_Title')
  SceneController:Add("menu",       'Scenes/Scene_Menu')
  SceneController:Add("gameplay",   'Scenes/Scene_Gameplay')
  SceneController:Add("gameOver",   'Scenes/Scene_Game_Over')
  SceneController:Add("highScores", 'Scenes/Scene_HighScores')
  SceneController:Start()
end


----------
-- load --
----------
function love.load()
  love.window.setTitle(GAME_NAME)
    
  Helpers = require("Libraries/Helpers").new()
  
  -- ECS
  p_Entity             = require 'Libraries/ECS/Parents/p_Entity'
  p_Component          = require 'Libraries/ECS/Parents/p_Component'
  p_System             = require 'Libraries/ECS/Parents/p_System'
  
  -- classes
  Resolution           = require('Libraries/Resolution').new()
  Input                = require('Libraries/Input/InputController')
  StateMachine         = require('Libraries/StateMachine')
  Timers               = require('Libraries/Timers')
  Vector2              = require('Libraries/Vector2')
  Camera               = require('Libraries/Camera/Camera')
  TransitionController = require('Controllers/TransitionController')
  SceneController      = require('Controllers/SceneController')   
  
  Resolution:SetWindow(screenWidth, screenHeight, 2, fullscreen) 
  
  surface = love.graphics.newCanvas(screenWidth, screenHeight)
  
  love.graphics.setColor(0, 0, 0, 1)
  love.graphics.setCanvas(surface)
    love.graphics.rectangle("fill", 0, 0, Resolution.screen.width, Resolution.screen.height)
  love.graphics.setCanvas()
  love.graphics.setColor(1, 1, 1, 1)
  
  surface:setFilter("nearest", "nearest")
  
  vignette = love.graphics.newImage("Images/Vignette/Vignette1440p.png")
  
  -- Load stuff
  Input:Load()
  Input.keyboard:SetAxies({["left"] = "left", ["right"] = "right", ["up"] = "up", ["down"] = "down"})
  Input.keyboard:SetButtons({["button1"] = "space", ["button2"] = "lctrl", ["button3"] = "lshift", ["button4"] = "return"})  
  
  TransitionController:Load()
  LoadScenes()
end

------------
-- update --
------------
function love.update(dt)
  --if(debug) then
    if(love.keyboard.isDown("escape")) then love.event.quit() end
  --end
  
  Input:Update(dt)
  SceneController:Update(dt)
  TransitionController:Update(dt)
  Camera:Update(dt)
end

----------
-- draw --
----------
function love.draw()  
  Resolution:Set()
    love.graphics.setBackgroundColor(0.5, 0.5, 0.5, 1)
      love.graphics.setColor(1, 1, 1, 1)
        love.graphics.setCanvas(surface)
          love.graphics.clear()
            Camera:Set()
              SceneController:Draw()
        love.graphics.setCanvas()
            Camera:UnSet()
  
  Resolution:UnSet()
  
  love.graphics.draw(surface, 0, 0, 0, Resolution.scale, Resolution.scale)
    
  love.graphics.setColor(1, 1, 1, 0.1)
    love.graphics.draw(vignette, 0, 0)
  love.graphics.setColor(1, 1, 1, 1)
  
  SceneController:DrawGUI()  
  TransitionController:Draw()
  
  if(debug) then love.graphics.print(tostring(love.timer.getFPS(), 10, 10)) end
end