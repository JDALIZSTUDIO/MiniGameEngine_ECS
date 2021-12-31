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
    
    local aspect, camera, scene_manager, surface, transition, vignette, vignetteSX, vignetteSY
    
    function Class:Set_Aspect(_pW, _pH, _pScale, _pFullscreen)
      aspect:SetWindow(_pW, _pH, _pScale, _pFullscreen)      
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
      Locator:Add_Service("aspect",        require('Core/Libraries/Aspect').new())
      Locator:Add_Service("easing",        require('Core/Libraries/Easing').new())
      Locator:Add_Service("f_entity",      require('Core/Libraries/ECS/Factories/f_Entity'))
      Locator:Add_Service("f_component",   require('Core/Libraries/ECS/Factories/f_Component'))
      Locator:Add_Service("f_system",      require('Core/Libraries/ECS/Factories/f_System'))
      Locator:Add_Service("f_controller",  require('Core/Libraries/ECS/Factories/f_Controller'))
      Locator:Add_Service("f_character",   require('Core/Libraries/ECS/Factories/f_Character')) 
      Locator:Add_Service("f_fx",          require('Core/Libraries/ECS/Factories/f_FX'))
      Locator:Add_Service("f_particle",    require('Core/Libraries/ECS/Factories/f_Particle'))
      Locator:Add_Service("f_Part_Params", require('Core/Libraries/ECS/Factories/f_Particle_Parameters'))
      Locator:Add_Service("f_emitter",     require('Core/Libraries/ECS/Factories/f_Emitter'))
      Locator:Add_Service("sceneManager",  require('Core/Libraries/Scenes/Scene_Manager').new())
      Locator:Add_Service("spriteLoader",  require('Core/Libraries/Sprite_Loader').new())
      Locator:Add_Service("camera",        require('Core/Libraries/Camera/Camera').new())
      Locator:Add_Service("transition",    require('Core/Libraries/Transition').new())
      Locator:Add_Service("timers",        require('Core/Libraries/Timers'))
      
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

      aspect        = Locator:Get_Service("aspect")
      camera        = Locator:Get_Service("camera")
      scene_manager = Locator:Get_Service("sceneManager")
      transition    = Locator:Get_Service("transition")

      camera:Load()

      self.globals = require('Core/Globals/Globals')
      self.globals:Load()
      
      self.helpers = require('Core/Libraries/Helpers').new()

      self:Set_Aspect(screenWidth, screenHeight, screenScale, fullscreen)      
      vignette = require('Core/Libraries/Vignette').new()
      vignette:Set_Texture("Core/Images/Vignette/Vignette1280x720.png")
      
      self:_Load_Assets()
      self:On_Load()
      self:_Load_Scenes()
      scene_manager:Start()
    end
    
    ------------
    -- Update --
    ------------
    function Class:Update(dt)
      Input:Update(dt)
      scene_manager:Update(dt)
      camera:Update(dt)
      transition:Update(dt)

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
          camera:Set()
            scene_manager:Draw()
          camera:UnSet()
        love.graphics.setCanvas()

        if(fullscreen) then
          local w = love.graphics.getWidth() / surface:getWidth()
          local h = love.graphics.getHeight() / surface:getHeight()
          love.graphics.draw(surface, 0, 0, 0, w, h)
        else
          aspect:Set()
            love.graphics.draw(surface, 0, 0, 0)
          aspect:UnSet()
        end      
        
      vignette:Draw()
      
      scene_manager:Draw_GUI()  
      transition:Draw()
    end
    
    return Class
  end
}