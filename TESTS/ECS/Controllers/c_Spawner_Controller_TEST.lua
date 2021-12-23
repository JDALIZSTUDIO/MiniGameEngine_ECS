local factory  = require('Core/Libraries/ECS/Components/Controllers/c_Character_Controller')

return {
  new = function(_pECS)
    local component = factory.new(_pECS)
          
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
    
    -----------------------
    -- OnEntityCollision --
    -----------------------
    function component:OnEntityCollision(_pTable)
      
    end    
    
    return component
  end
}