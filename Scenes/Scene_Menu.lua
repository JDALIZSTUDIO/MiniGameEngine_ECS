local Scene = require('Scenes/Scene_Parent')

local GUI

-- Load / Update / Draw

function Scene:Load()
  Camera:SetPosition(0, 0)
  
  -- Transitions
  local fnTransPlay = function()
    SceneController:Next()
  end
  
  local fnTransQuit = function()
    love.event.quit(0)
  end
  
  
  -- GUI functions
  local fnPlay = function()
    TransitionController:Start(fnTransPlay)
  end

  local fnOptions = function()
    
  end

  local fnQuit = function()
    TransitionController:Start(fnTransQuit)
  end
  
  -- GUI
  
  GUI = self.GUI_Controller
  local x = Round(Resolution.window.width/2)
  
  local sf = love.graphics.newImageFont('Libraries/GUI/Sprites/spr_Kromasky.png',' abcdefghijklmnopqrstuvwxyz0123456789!?:;,è./+%ç@à#')
  local label = GUI:Add(GUI:SpriteFont(x, Round(Resolution.window.height/4), GAME_NAME, sf, 3))
  
  GUI:Add(GUI:Button(x, Round(Resolution.window.height/1.8), "Play",    "Libraries/GUI/Sprites/ButtonStrip.png", 4, fnPlay))
  GUI:Add(GUI:Button(x, Round(Resolution.window.height/1.6), "Options", "Libraries/GUI/Sprites/ButtonStrip.png", 4, fnOptions))
  GUI:Add(GUI:Button(x, Round(Resolution.window.height/1.3), "Quit",    "Libraries/GUI/Sprites/ButtonStrip.png", 4, fnQuit))
  
  if (debug) then print("Scenes,  loaded:      "..Scene.name) end
end

function Scene:Unload()
  if (debug) then print("Scenes,  unLoaded:    "..Scene.name) end
end

function Scene:Update(dt)
  self.GUI_Controller:Update(dt)
end

function Scene:Draw()
  
end

function Scene:DrawGUI()
  if(self.GUI_Controller ~= nil) then
    self.GUI_Controller:Draw()
    
  end
end

return Scene