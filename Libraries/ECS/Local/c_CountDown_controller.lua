local character_controller = require('Libraries/ECS/Components/c_Character_Controller')

return {
  new = function()
    local Controller = character_controller.new()
          local state   = require('Libraries/StateMachine').new({"NONE"})
          local timers  = require('Libraries/Timers')
          local timer   = nil                
          local target  = nil
          local counter = 3
          
          function Controller:Load()
            timer = timers:Add("start", 30)
          end
          
          function Controller:SetTarget(_pTransform)
            target = _pTransform.position
            
          end
          
          function Controller:Update(dt)
            timers.Update(dt)
          end
          
          function Controller:Draw()
            love.graphics.print()
          end
  
    return Controller
  end
}