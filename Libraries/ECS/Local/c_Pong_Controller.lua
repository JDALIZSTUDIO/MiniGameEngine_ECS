local CController = require('Libraries/ECS/Components/c_Player_Controller')

return {
  new = function(_pECS)
    local Controller = CController.new(_pECS)
          Controller.ready = false
    
    local maxSpeed   = 100
    local inputDir   = Vector2:New(8)
    
    local fnt = love.graphics.newFont()
          
          function Controller:Custom_Load(_pEntity)
            
          end
          
          function Controller:Process_Input(dt, _pEntity)
            inputDir:Set(0, 0)
            
            if(Input.keyboard:GetAxis("up") == true) then
              inputDir.y = -1
              
            elseif(Input.keyboard:GetAxis("down") == true) then
              inputDir.y = 1
              
            end
            
          end
          
          function Controller:Update_Logic(dt, _pEntity)
            local transform = _pEntity:GetComponent("transform")
                  transform.velocity.y = inputDir.y * maxSpeed
          end
          
          function  Controller:Draw(_pEntity)
            local bBox      = _pEntity:GetComponent("boxCollider")
            local transform = _pEntity:GetComponent("transform")
            
          end
  
    return Controller
  end
}