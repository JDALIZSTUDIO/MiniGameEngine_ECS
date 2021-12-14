local factory  = require('Libraries/ECS/Components/c_Character_Controller')
local keyboard = require("Libraries/Input/KeyboardInput")

return {
  new = function(_pECS)
    local component = factory.new(_pECS)
          
    function component:Custom_Load()  
      
    end
    
    function component:Process_Input()  
      
    end
    
    function component:Update_Logic(dt)  
      
    end
    
    function component:Load()
      self:Custom_Load()
    end

    function component:Update(dt)
      self:Process_Input(dt)
      self:Update_Logic(dt)
    end
    
    function component:Draw()
      
    end
    
    return component
  end
}