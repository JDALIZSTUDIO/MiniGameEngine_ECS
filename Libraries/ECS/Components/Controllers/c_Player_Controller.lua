local factory  = require('Libraries/ECS/Components/Controllers/c_Character_Controller')

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
    
    ----------
    -- Load --
    ----------
    function component:Load()
      self:Custom_Load()
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
    
    return component
  end
}