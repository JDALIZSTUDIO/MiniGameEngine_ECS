return {
  new = function()
    local f_controller = Locator:Get_Service("f_controller")
    local component    = f_controller.new()
        
    -------------
    -- Animate --
    -------------
    function component:Animate()  
    
    end

    -----------------
    -- Custom_Load --
    -----------------
    function component:Custom_Load()  
      
    end
    
    ----------------
    -- On_Destroy --
    ----------------
    function component:On_Destroy()  
    
    end

    -------------------
    -- Process_Input --
    -------------------
    function component:Process_Input(dt)  
      
    end
    
    ------------------
    -- Update_Logic --
    ------------------
    function component:Update_Logic(dt)  
      
    end
    
    ----------
    -- Load --
    ----------
    function component:Load()
      self:Custom_Load()
    end

    ------------
    -- Update --
    ------------
    function component:Update(dt)
      self:Process_Input(dt)
      self:Update_Logic(dt)
      self:Animate()
    end
    
    ----------
    -- Draw --
    ----------
    function component:Draw()
      
    end
    
    --------------
    -- Draw_GUI --
    --------------
    function component:Draw_GUI()
      
    end

    return component
  end
}