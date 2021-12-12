local Player_Controller = require('Libraries/ECS/Components/c_Player_Controller')

return {
  new = function()
    local Controller = Player_Controller.new()
          Controller.ready = false
    
    local maxSpeed   = 100
    local inputDir   = Vector2:New()
          
          function Controller:Custom_Load(_pOwner)
            
          end
          
          function Controller:Process_Input(dt, _pOwner)
            inputDir:Set(0, 0)
            
            if(Input.keyboard:GetAxis("up") == true) then
              inputDir.y = -1
              
            elseif(Input.keyboard:GetAxis("down") == true) then
              inputDir.y = 1
              
            end
            
          end
          
          function Controller:Update_Logic(dt, _pOwner)
            local transform = _pOwner:GetComponent("transform")
                  transform.velocity.y = inputDir.y * maxSpeed
          end
  
    return Controller
  end
}