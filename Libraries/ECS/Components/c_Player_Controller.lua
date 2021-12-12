local factory  = require('Libraries/ECS/Components/c_Character_Controller')
local keyboard = require("Libraries/Input/KeyboardInput")

return {
  new = function()
    local PC = factory.new()
          
    function PC:Custom_Load(_pOwner)  
      
    end
    
    function PC:Process_Input(_pOwner)  
      
    end
    
    function PC:Update_Logic(dt, _pOwner)  
      
    end
    
    function PC:Load(_pOwner)
      PC:Custom_Load(_pOwner)
    end

    function PC:Update(dt, _pOwner)
      self:Process_Input(dt, _pOwner)
      self:Update_Logic(dt, _pOwner)
    end
    
    function PC:Draw(_pOwner)
      
    end
    
    return PC
  end
}