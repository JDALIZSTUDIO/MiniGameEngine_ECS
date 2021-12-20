return {
  new = function(_pECS)
    local component = p_Component.new("characterController")
          component.ECS = _pECS or nil
    
    -----------------
    -- Custom_Load --
    -----------------
    function component:Custom_Load()  
    
    end
    
    -------------------
    -- Process_Input --
    -------------------
    function component:Process_Input()  
      
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
      component:Custom_Load()
    end

    ------------
    -- Update --
    ------------
    function component:Update(dt)
      self:Process_Input(dt)
      self:Update_Logic(dt)
    end
    
    ----------
    -- Draw --
    ----------
    function component:Draw()
      
    end
    
    -----------------------
    -- OnEntityCollision --
    -----------------------
    function component:OnEntityCollision(_pTable)
      
    end
    
    ---------------------
    -- OnTileCollision --
    ---------------------
    function component:OnTileCollision(_pTileID)
      
    end
    
    return component
  end
}