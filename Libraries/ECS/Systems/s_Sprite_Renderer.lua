return {
  new = function()
    local system = p_System.new({"transform", "spriteRenderer"})
  
    function system:Load(_pEntity)
      
      local surface
      
      if(debug) then print("Systems, loaded:      SpriteRenderer by ".._pEntity.name) end
    end
    
    function system:Draw(_pEntity)
      local dropShadow   = _pEntity:GetComponent("dropShadow")
      local transform    = _pEntity:GetComponent("transform")
      local renderer     = _pEntity:GetComponent("spriteRenderer")      
      if(renderer.active == false) then return end
      
      if(renderer.shader ~= nil) then 
        if(renderer.shader.active) then renderer.shader:Set() end 
      end
      
      if(dropShadow ~= nil) then
        love.graphics.setColor(0, 0, 0, dropShadow.alpha)
      
        love.graphics.draw(renderer.sprite, 
                           transform.position.x + dropShadow.offset.x, 
                           transform.position.y + dropShadow.offset.y, 
                           math.rad(transform.rotation), 
                           transform.scale.x, 
                           transform.scale.y, 
                           renderer.halfW, 
                           renderer.halfH,
                           0,
                           0)
      end
      
      love.graphics.setColor(1, 1, 1, renderer.alpha)
      
      love.graphics.draw(renderer.sprite, 
                         transform.position.x, 
                         transform.position.y, 
                         math.rad(transform.rotation), 
                         transform.scale.x, 
                         transform.scale.y, 
                         renderer.halfW, 
                         renderer.halfH,
                         0,
                         0)
                       
      if(renderer.shader ~= nil) then renderer.shader:UnSet() end
    end
    
    return system  
  end
}