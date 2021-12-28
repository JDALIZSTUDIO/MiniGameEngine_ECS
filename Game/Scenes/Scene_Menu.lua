return {
  new = function(_pName)
    local Scene = require('Core/Libraries/Scenes/Scene_Default').new(_pName)
    
    local aspect = Locator:Get_Service("aspect")
    local camera = Locator:Get_Service("camera")
    local floor  = math.floor

    ----------
    -- Load --
    ----------
    function Scene:Load()
      camera:Look_At(0, 0)
      
      -----------------
      -- Transitions --
      -----------------
      local fnTransPlay = function()
        local scene_manager = Locator:Get_Service("sceneManager")
        scene_manager:Next()
      end
      
      local fnTransQuit = function()
        love.event.quit(0)
      end      
      
      -------------------
      -- GUI_functions --
      -------------------
      local fnPlay = function()
        local transition = Locator:Get_Service("transition")
        transition:Start(fnTransPlay)
      end

      local fnOptions = function()
        
      end

      local fnQuit = function()
        local transition = Locator:Get_Service("transition")
        transition:Start(fnTransQuit)
      end

      ------------------
      -- GUI_elements --
      ------------------
      local x = Round(aspect.window.width/2)      
      local sf = love.graphics.newImageFont('Game/Images/SpriteFonts/spr_Kromasky.png',' abcdefghijklmnopqrstuvwxyz0123456789!?:;,è./+%ç@à#')
      self.GUI:Add(self.GUI.element.spriteFont.new(x, floor(aspect.window.height/4), "my game", sf, {x=3, y=3}))      
      self.GUI:Add(self.GUI.element.button.new(x, Round(aspect.window.height/1.8), "Play",    "Core/Libraries/GUI/Sprites/ButtonStrip.png", 96, 32, fnPlay))
      self.GUI:Add(self.GUI.element.button.new(x, Round(aspect.window.height/1.6), "Options", "Core/Libraries/GUI/Sprites/ButtonStrip.png", 96, 32, fnOptions))
      self.GUI:Add(self.GUI.element.button.new(x, Round(aspect.window.height/1.3), "Quit",    "Core/Libraries/GUI/Sprites/ButtonStrip.png", 96, 32, fnQuit))
      
      if (isDebug) then print("Scenes,  loaded:      "..Scene.name) end
    end

    return Scene
  end
}