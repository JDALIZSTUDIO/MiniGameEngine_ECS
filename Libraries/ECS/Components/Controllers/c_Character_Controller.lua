return {
  new = function(_pECS)
    local component = p_Component.new("characterController")
          component.ECS = _pECS or nil
    
    function component:Custom_Load()  
    
    end
    
    function component:Process_Input()  
      
    end
    
    function component:Update_Logic(dt)  
      
    end
    
    function component:Load()
      component:Custom_Load()
    end

    function component:Update(dt)
      self:Process_Input(dt)
      self:Update_Logic(dt)
    end
    
    function component:Draw()
      
    end
    
    ----------------
    -- collisions --
    ----------------
    function component:OnEntityCollision(_pTable)
      
    end
    
    function component:OnTileCollision(_pTileID)
      
    end
    
    return component
  end
}