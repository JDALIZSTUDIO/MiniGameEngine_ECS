return {
  new = function()
    local f_controller = Locator:Get_Service("f_controller")
    local component    = f_controller.new()
        
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
        
    ------------------
    -- On_Animation --
    ------------------
    function component:On_Animation()  
    
    end

    ----------------
    -- On_Destroy --
    ----------------
    function component:On_Destroy()  
    
    end

    -------------------
    -- On_Input --
    -------------------
    function component:On_Input(dt)  
      
    end
    
    ------------------
    -- On_Update --
    ------------------
    function component:On_Update(dt)  
      
    end

    ------------
    -- Update --
    ------------
    function component:Update(dt)
      self:On_Input(dt)
      self:On_Update(dt)
      self:On_Animation()
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