return {
  new = function()
    local f_controller = Locator:Get_Service("f_controller")
    local component    = f_controller.new()
      
    local an = "animator"
    local bb = "boundingBox"
    local bc = "boxCollider"
    local ch = "characterController"
    local he = "health"
    local rb = "rigidBody"
    local tr = "transform"
    
    local state  = nil

    -------------
    -- Animate --
    -------------
    function component:Animate()
      local animator = self.gameObject:Get_Component(an)
      if(state:Compare("HURT")) then
        if(animator:Is_Finished("hurt")) then 
          animator:Play("idle")
          state:Set("IDLE") end
        end
    end

    ----------
    -- Load --
    ----------
    function component:Load()
      state  = require('Core/Libraries/State_Machine').new({"IDLE", "HURT", "DEATH", "DEAD"})
      state:Set("IDLE")

      --local transform = self.gameObject:Get_Component(tr)
      --love.event.push("Set_Collision", {x = transform.position.x, y = transform.position.y})
    end

    -------------
    -- Explode --
    -------------
    function component:Explode()

    end

    ----------
    -- Kill --
    ----------
    function component:Kill()
      local animator = self.gameObject:Get_Component(an)
      local collider = self.gameObject:Get_Component(bc)
      local rigid = self.gameObject:Get_Component(rb)      
      animator:Play("death")
      collider.active = false
      rigid.active    = false
      state:Set("DEATH")
    end
    
    ---------------
    -- On_Damage --
    ---------------
    function component:On_Damage()  
      local animator = self.gameObject:Get_Component(an)
            animator:Play("idle")
            animator:Play("hurt")

      state:Set("HURT")
    end

    ----------------
    -- On_Destroy --
    ----------------
    function component:On_Destroy()  
      local transform = self.gameObject:Get_Component(tr)
      --love.event.push("UnSet_Collision", {x = transform.position.x, y = transform.position.y})
    end
    
    -----------------------
    -- On_Entity_Collision --
    -----------------------
    function component:On_Entity_Collision(_pTable)
      if(not state:Compare("DEATH")) then
        local other
        for i = 1, #_pTable do
          other = _pTable[i]
          if(other.name == "bullet") then
            if(self:Hurt(other:Get_Component(ch).damage)) then
              self:Kill()
              self:Explode()
            end
            other.Destroy()
          end
        end
      end
    end
    
    ------------------
    -- Update_Logic --
    ------------------
    function component:Update_Logic(dt)
      local current = state:Get_Name()
      if(current == "DEATH") then
        local animator = self.gameObject:Get_Component(an)
        if(animator ~= nil) then
          if(animator:Is_Finished("death")) then
            self.gameObject:Destroy() 
            state:Set("DEAD")
          end
        end
      end
    end
    
    return component
  end
}