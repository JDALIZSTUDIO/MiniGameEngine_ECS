local CController = require('Libraries/ECS/Components/c_Player_Controller')

return {
  new = function(_pECS)
    local Controller = CController.new(_pECS)
          Controller.ready = false
    
    local maxSpeed = 100
    local steering = nil
    local target   = nil
    
    local fnt = love.graphics.newFont()
          
    function Controller:Custom_Load(_pEntity)
      steering = _pEntity:GetComponent("steering")
    end
    
    function Controller:Process_Input(dt, _pEntity)
      
    end
    
    function Controller:Update_Logic(dt, _pEntity)
      if(target == nil) then
        local t = self.GameObject:Find("ball")
        if(t ~= nil) then target = t end
      end
      
      local transform = _pEntity:GetComponent("transform")
      
      steering:Arrive(transform.position.x, target.position.y)
      
    end
    
    function  Controller:Draw(_pEntity)
      
    end
  
    return Controller
  end
}