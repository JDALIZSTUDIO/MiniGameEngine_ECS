return {
  new = function()
    local f_component = Locator:Get_Service("f_component")
    local component   = f_component.new("characterController")

    -------------
    -- Animate --
    -------------
    function component:Animate()  
    
    end
    
    ----------
    -- Hurt --
    ----------
    function component:Hurt(_pDamage)
      local health = self.gameObject:Get_Component("health")
      if(health == nil) then return false end
      if(health:Hurt(_pDamage)) then
        return true
      end
      self:On_Damage()
      return false
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

    -------------------
    -- Process_Input --
    -------------------
    function component:Process_Input(dt)  
      
    end

    ------------
    -- Update --
    ------------
    function component:Update(dt)
      self:Process_Input(dt)
      self:Update_Logic(dt)
      self:Animate()
    end
    
    ------------------
    -- Update_Logic --
    ------------------
    function component:Update_Logic(dt)  
      
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

    -----------------------
    -- On_Entity_Collision --
    -----------------------
    function component:On_Entity_Collision(_pTable)
      
    end
    
    ---------------------
    -- On_Tile_Collision --
    ---------------------
    function component:On_Tile_Collision(_pTileID)
      
    end
    
    return component
  end
}