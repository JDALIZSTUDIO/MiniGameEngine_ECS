return {
  new = function(_pName)
    local coreGame = {
      name    = _pName or "Default game Name",
      globals = nil,
      helpers = nil
    }
    
    local colorBG      = {24/255, 20/255, 37/255, 1}
    local fullscreen   = false
    local screenScale  = 2
    local screenWidth  = 640
    local screenHeight = 360
    
    local surface, vignette, vignetteSX, vignetteSY
    
    function coreGame:Set_Aspect(_pW, _pH, _pScale, _pFullscreen)
      Aspect:SetWindow(_pW, _pH, _pScale, _pFullscreen)      
      surface = love.graphics.newCanvas(_pW, _pH)
      surface:setFilter("nearest", "nearest", 16)
    end

    -----------------
    -- Load_Scenes --
    -----------------
    function coreGame:Load_Scenes()
      
    end
    
    ----------
    -- Load --
    ----------
    function coreGame:Load()
      love.window.setTitle(coreGame.name)
      self.globals = require('Core/Globals/Globals')
      self.globals:Load()
      
      self.helpers = require('Core/Libraries/Helpers').new()

      self:Set_Aspect(screenWidth, screenHeight, screenScale, fullscreen)      
      vignette = require('Core/Libraries/Vignette').new()
      vignette:Set_Texture("Core/Images/Vignette/Vignette1280x720.png")

      Input.keyboard:SetAxies({["left"] = "left", ["right"] = "right", ["up"] = "up", ["down"] = "down"})
      Input.keyboard:SetButtons({["button1"] = "space", ["button2"] = "lctrl", ["button3"] = "lshift", ["button4"] = "return"})  
      
      self:Load_Scenes()
      Scene_Manager:Start()
    end
    
    ------------
    -- Update --
    ------------
    function coreGame:Update(dt)
      Input:Update(dt)
      Scene_Manager:Update(dt)
      Camera:Update(dt)
      Transition:Update(dt)

      vignette:Update(dt)
    end
    
    ----------
    -- Draw --
    ----------
    function coreGame:Draw()
      love.graphics.setBackgroundColor(colorBG)
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.setCanvas(surface)
        love.graphics.clear()
          Camera:Set()
            Scene_Manager:Draw()
          Camera:UnSet()
        love.graphics.setCanvas()

        if(fullscreen) then
          local w = love.graphics.getWidth() / surface:getWidth()
          local h = love.graphics.getHeight() / surface:getHeight()
          love.graphics.draw(surface, 0, 0, 0, w, h)
        else
          Aspect:Set()
            love.graphics.draw(surface, 0, 0, 0)
          Aspect:UnSet()
        end      
        
      vignette:Draw()
      
      Scene_Manager:Draw_GUI()  
      Transition:Draw()
    end
    
    return coreGame
  end
}