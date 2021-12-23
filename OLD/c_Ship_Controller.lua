local character_controller = require('Core/Libraries/ECS/Components/c_Parent_Controller')

return {
  new = function()
    local controller = character_controller.new()
          local target    = nil
          local transform = nil
          local steering  = nil
          
          function controller:Load(_pOwner)
            steering  = _pOwner:Get_Component("steering")
            transform = _pOwner:Get_Component("transform")
            target = Vector2.new(transform.position.x, transform.position.y)
          end
          
          function controller:Update(dt, _pOwner)
            transform = _pOwner:Get_Component("transform")
            local mx, my = love.mouse.getPosition()
            
            if(mx > 0 and mx < love.graphics.getWidth() and 
               my > 0 and my < love.graphics.getHeight()) then
              if(love.mouse.isDown(1)) then
                target:Set(mx, my)
              end
            end
            
            local render = _pOwner:Get_Component("spriteRenderer")
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