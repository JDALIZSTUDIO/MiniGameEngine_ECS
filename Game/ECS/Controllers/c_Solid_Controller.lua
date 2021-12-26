local factory  = require('Core/Libraries/ECS/Components/Controllers/c_Parent_Controller')

return {
  new = function()
    local component = factory.new()
      
    local an = "animator"
    local bb = "boundingBox"
    local ch = "characterController"
    local he = "health"
    local tr = "transform"

    local state  = nil

    -----------------
    -- Custom_Load --
    -----------------
    function component:Custom_Load()
      state  = require('Core/Libraries/State_Machine').new({"IDLE", "DEATH", "DEAD"})
      state:Set("IDLE")

      --local transform = self.gameObject:Get_Component(tr)
      --love.event.push("Set_Collision", {x = transform.position.x, y = transform.position.y})
    end

    -------------
    -- Explode --
    -------------
    function component:Explode()

    end

    ---------------
    -- Kill_Self --
    ---------------
    function component:Kill_Self()
      local animator = self.gameObject:Get_Component(an)
            animator:Play("death")
      state:Set("DEATH")
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
      if(state:Compare("IDLE")) then
        local other
        for i = 1, #_pTable do
          other = _pTable[i]
          if(other.name == "bullet") then
            local health = self.gameObject:Get_Component(he)
            if(health ~= nil) then
              health:Hurt(other:Get_Component(ch).damage)
              if(health.health <= 0) then
                self:Kill_Self()
                self:Explode()
              end
              other.Destroy() 
            end
          end
        end
      end
    end
    
    ------------
    -- Update --
    ------------
    function component:Update(dt)
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