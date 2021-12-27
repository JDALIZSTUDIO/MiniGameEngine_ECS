return {
  new = function(_pName)
    local Class = {
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
    
    function Class:Set_Aspect(_pW, _pH, _pScale, _pFullscreen)
      Aspect:SetWindow(_pW, _pH, _pScale, _pFullscreen)      
      surface = love.graphics.newCanvas(_pW, _pH)
      surface:setFilter("nearest", "nearest", 16)
    end
    
    ------------------
    -- _Load_Assets --
    ------------------
    function Class:_Load_Assets()      
      self:On_Load_Assets()
    end

    ------------------
    -- _Load_Scenes --
    ------------------
    function Class:_Load_Scenes()
      self:On_Load_Scenes()
    end
    
    --------------------
    -- _Load_Services --
    --------------------
    function Class:_Load_Services()
      Locator:Add_Service("spriteLoader", require('Core/Libraries/Sprite_Loader').new())      
      self:On_Load_Services()
    end

    -------------
    -- On_Load --
    -------------
    function Class:On_Load()

    end

    --------------------
    -- On_Load_Assets --
    --------------------
    function Class:On_Load_Assets()
      
    end

    -------------------------
    -- On_Load_Load_Scenes --
    -------------------------
    function Class:On_Load_Load_Scenes()      
      
    end
    
    ----------------------
    -- On_Load_Services --
    ----------------------
    function Class:On_Load_Services()
      
    end    
    
    ----------
    -- Load --
    ----------
    function Class:Load()
      love.window.setTitle(Class.name)

      self:_Load_Services()

      self.globals = require('Core/Globals/Globals')
      self.globals:Load()
      
      self.helpers = require('Core/Libraries/Helpers').new()

      self:Set_Aspect(screenWidth, screenHeight, screenScale, fullscreen)      
      vignette = require('Core/Libraries/Vignette').new()
      vignette:Set_Texture("Core/Images/Vignette/Vignette1280x720.png")
      
      self:_Load_Assets()
      self:On_Load()
      self:_Load_Scenes()
      Scene_Manager:Start()
    end
    
    ------------
    -- Update --
    ------------
    function Class:Update(dt)
      Input:Update(dt)
      Scene_Manager:Update(dt)
      Camera:Update(dt)
      Transition:Update(dt)

      vignette:Update(dt)
    end
    
    ----------
    -- Draw --
    ----------
    function Class:Draw()
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
    
    return Class
  end
}