return {
  new = function(_pName)
    local Scene = require('Libraries/Scenes/Scene_Default').new(_pName)
    
    ----------
    -- Load --
    ----------
    function Scene:Load()
      Camera:SetPosition(0, 0)
      
      -----------------
      -- Transitions --
      -----------------
      local fnTransPlay = function()
        Scene_Manager:Next()
      end
      
      local fnTransQuit = function()
        love.event.quit(0)
      end      
      
      -------------------
      -- GUI_functions --
      -------------------
      local fnPlay = function()
        Transition:Start(fnTransPlay)
      end

      local fnOptions = function()
        
      end

      local fnQuit = function()
        Transition:Start(fnTransQuit)
      end

      ------------------
      -- GUI_elements --
      ------------------
      local x = Round(Aspect.window.width/2)      
      local sf = love.graphics.newImageFont('Libraries/GUI/Sprites/spr_Kromasky.png',' abcdefghijklmnopqrstuvwxyz0123456789!?:;,è./+%ç@à#')
      local label = self.GUI:Add(self.GUI:SpriteFont(x, Round(Aspect.window.height/4), GAME_NAME, sf, 3))      
      self.GUI:Add(self.GUI:Button(x, Round(Aspect.window.height/1.8), "Play",    "Libraries/GUI/Sprites/ButtonStrip.png", 4, fnPlay))
      self.GUI:Add(self.GUI:Button(x, Round(Aspect.window.height/1.6), "Options", "Libraries/GUI/Sprites/ButtonStrip.png", 4, fnOptions))
      self.GUI:Add(self.GUI:Button(x, Round(Aspect.window.height/1.3), "Quit",    "Libraries/GUI/Sprites/ButtonStrip.png", 4, fnQuit))
      
      if (isDebug) then print("Scenes,  loaded:      "..Scene.name) end
    end

    return Scene
  end
}