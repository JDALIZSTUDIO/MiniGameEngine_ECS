local factory  = require('Core/Libraries/ECS/Components/Controllers/c_Parent_Controller')

return {
  new = function()
    local component = factory.new()
      
    local bb = "boundingBox"
    local ch = "characterController"
    local he = "health"
    local tr = "transform"

    -----------------
    -- Custom_Load --
    -----------------
    function component:Custom_Load()
      local transform = self.gameObject:Get_Component(tr)
      --love.event.push("Set_Collision", {x = transform.position.x, y = transform.position.y})
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
      local other
      for i = 1, #_pTable do
        other = _pTable[i]
        if(other.name == "bullet") then
          local health = self.gameObject:Get_Component(he)
          if(health ~= nil) then health:Hurt(other:Get_Component(ch).damage) other.Destroy() end
        end
      end
    end
    
    
    return component
  end
}