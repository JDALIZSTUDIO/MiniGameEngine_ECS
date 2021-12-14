return {
  new = function(_pName)

    local Scene   = {
          active  = true,
          loaded  = false,
          name    = _pName or "Default",
          GUI     = nil,
          Surface = nil,
    }

    ----------------------
    -- PUBLIC FUNCTIONS --
    ----------------------

    -----------
    -- Awake --
    ----------- 
    function Scene:Awake()
      
    end

    ------------
    -- Unload --
    ------------
    function Scene:Unload()

    end

    ---------------
    -- PreUnload --
    ---------------
    function Scene:PreUnload()
      
    end

    ----------
    -- Load --
    ----------
    function Scene:Load()
      
    end

    ------------
    -- Update --
    ------------
    function Scene:Update(dt)

    end

    ----------
    -- Draw --
    ----------
    function Scene:Draw()

    end

    -------------
    -- Draw_GUI --
    -------------
    function Scene:Draw_GUI()
      if(self.GUI ~= nil) then
        self.GUI:Draw()    
      end
    end


    -----------------------
    -- PRIVATE FUNCTIONS --
    -----------------------

    ------------
    -- _Awake --
    ------------  
    function Scene:_Awake()
      self.GUI = require('Libraries/GUI/GUI_Factory')
      self:Awake()

      if (debug) then print("Scenes,  awoken:      "..Scene.name) end
    end

    -------------
    -- _Unload --
    -------------
    function Scene:_Unload()
      self:Unload()
    end

    ----------------
    -- _PreUnload --
    ----------------
    function Scene:_PreUnload()
      self.GUI:UnLoad()
      self.GUI = nil
      self:PreUnload()
      if (debug) then print("Scenes,  preUnLoaded: "..Scene.name) end
    end

    -----------
    -- _Load --
    -----------
    function Scene:_Load()
      self:Load()
    end

    -------------
    -- _Update --
    -------------
    function Scene:_Update(dt)
      if(self.GUI ~= nil) then
        self.GUI:Update(dt)    
      end
      self:Update(dt)
    end

    -----------
    -- _Draw --
    -----------
    function Scene:_Draw()
      self:Draw()
    end

    --------------
    -- _Draw_GUI --
    --------------
    function Scene:_Draw_GUI()
      if(self.GUI ~= nil) then
        self.GUI:Draw()    
      end
      self:Draw_GUI()
    end

    return Scene
  end
}