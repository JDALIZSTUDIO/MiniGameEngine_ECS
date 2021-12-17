return {
  new = function() 
    local system = p_System.new({"transform", "boxCollider", "trailEmitter"})
    function system:Load(_pEntity)
      if(isDebug) then print("Systems, loaded:      s_Trail_Renderer by ".._pEntity.name) end
    end
    
    function system:Update(dt, _pEntity)
      local emitter = _pEntity:GetComponent("trailEmitter")
      if(emitter.active == false) then return end
      
      emitter:Update(dt, _pEntity)
      
    end
    
    function system:Draw(_pEntity)
      local emitter   = _pEntity:GetComponent("trailEmitter")
      local renderer  = _pEntity:GetComponent("spriteRenderer")
      local transform = _pEntity:GetComponent("transform")
      
      if(emitter.active == false) then return end
      if(renderer.active == false) then return end
      
      if(renderer ~= nil) then
        local length = #emitter.trail
          if(length < 1) then return end
          
          local alpha, pos
          for i = 1, length do            
            alpha = i / length * renderer.alpha * 0.1
            love.graphics.setColor(1, 1, 1, alpha)
            
            trail = emitter.trail[i]
            love.graphics.draw(renderer.sprite, 
                               trail.x, 
                               trail.y, 
                               math.rad(trail.rotation), 
                               transform.scale.x, 
                               transform.scale.y, 
                               renderer.halfW, 
                               renderer.halfH,
                               0,
                               0)
        end
        
        renderer  = _pEntity:GetComponent("animator")
        if(renderer ~= nil) then
          
        end        
      end
    end
    
    return system 
  end
}