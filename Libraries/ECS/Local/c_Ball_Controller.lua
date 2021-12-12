local character_controller = require('Libraries/ECS/Components/c_Character_Controller')

return {
  new = function()
    local ball_controller = character_controller.new()
          local state = require('Libraries/StateMachine').new({"NONE", "START", "GAMEPLAY", "END"})
                state:Set("START")
                
          local target    = nil
          
          function ball_controller:SetTarget(_pTransform)
            target = _pTransform.position
            
          end
          
          function ball_controller:Update(dt, _pOwner)
            if(state:Compare("START") == true) then
              if(target ~= nil) then
                local dir = 1
                local transform = _pOwner:GetComponent("transform")
                      transform.position:Set(target.x + 8, target.y)
              end
            end
          end
          
          function ball_controller:Draw(_pOwner)
            
          end
  
    return ball_controller
  end
}