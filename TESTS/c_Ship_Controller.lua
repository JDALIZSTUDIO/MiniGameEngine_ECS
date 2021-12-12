local character_controller = require('Libraries/ECS/Components/c_Character_Controller')

return {
  new = function()
    local controller = character_controller.new()
          local target    = nil
          local transform = nil
          local steering  = nil
          
          function controller:Load(_pOwner)
            steering  = _pOwner:GetComponent("steering")
            transform = _pOwner:GetComponent("transform")
            target = Vector2:New(transform.position.x, transform.position.y)
          end
          
          function controller:Update(dt, _pOwner)
            transform = _pOwner:GetComponent("transform")
            local mx, my = love.mouse.getPosition()
            
            if(mx > 0 and mx < love.graphics.getWidth() and 
               my > 0 and my < love.graphics.getHeight()) then
              if(love.mouse.isDown(1)) then
                target:Set(mx, my)
              end
            end
            
            local render = _pOwner:GetComponent("spriteRenderer")
                  render.shader:SetUniform("aberration", math.floor(math.random(2.0, 32.0)))
            
            local dist = transform.position:Distance(target)
            if(dist > 1) then
              steering:Arrive(transform.position, target) 
            end
          end
          
          function controller:Draw(_pOwner)
            
          end
  
    return controller
  end
}