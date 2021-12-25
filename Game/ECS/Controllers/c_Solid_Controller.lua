local factory  = require('Core/Libraries/ECS/Components/Controllers/c_Parent_Controller')

return {
  new = function(_pECS)
    local component = factory.new(_pECS)
      
    local tr = "transform"

    -----------------
    -- Custom_Load --
    -----------------
    function component:Custom_Load()
        local transform = self.gameObject:Get_Component(tr)
        love.event.push("Set_Collision", {x = transform.position.x, y = transform.position.y})
    end
    
    ----------------
    -- On_Destroy --
    ----------------
    function component:On_Destroy()  
        local transform = self.gameObject:Get_Component(tr)
        love.event.push("UnSet_Collision", {x = transform.position.x, y = transform.position.y})
    end
    
    return component
  end
}