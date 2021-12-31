return {
  new = function()
    local f_component = Locator:Get_Service("f_component")
    local component   = f_component.new("characterController")

    ----------
    -- Hurt --
    ----------
    function component:Hurt(_pDamage)
      
    end    
    
    ----------
    -- Kill --
    ----------
    function component:Kill()
      
    end    
    
    ----------
    -- Load --
    ----------
    function component:Load()
      
    end    

    ------------------
    -- On_Animation --
    ------------------
    function component:On_Animation()  
    
    end
    
    ---------------
    -- On_Damage --
    ---------------
    function component:On_Damage()  
    
    end

    ----------------
    -- On_Destroy --
    ----------------
    function component:On_Destroy()  
    
    end

    --------------
    -- On_Input --
    --------------
    function component:On_Input(dt)  
      
    end

    ------------
    -- Update --
    ------------
    function component:Update(dt)
      self:On_Input(dt)
      self:On_Update(dt)
      self:On_Animation()
    end
    
    ---------------
    -- On_Update --
    ---------------
    function component:On_Update(dt)  
      
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

    ------------------------------
    -- On_Collision_With_Entity --
    ------------------------------
    function component:On_Collision_With_Entity(_pTable)
      
    end
    
    -------------------------------
    -- On_Collision_With_Tilemap --
    -------------------------------
    function component:On_Collision_With_Tilemap(_pTileID)
      
    end
    
    return component
  end
}