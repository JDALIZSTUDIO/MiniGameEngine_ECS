return {
  new = function() 
    local system = p_System.new({"transform", "boundingBox", "trailEmitter"})

    local an = "animator"
    local sr = "spriteRenderer"
    local te = "trailEmitter"
    local tr = "transform"

    ----------
    -- Load --
    ----------
    function system:Load(_pEntity)
      if(isDebug) then print("Systems, loaded:      s_Trail_Renderer by ".._pEntity.name) end
    end
    
    ------------
    -- Update --
    ------------
    function system:Update(dt, _pEntity)
      local emitter = _pEntity:GetComponent(te)
      if(emitter.active == false) then return end
      
      emitter:Update(dt, _pEntity)
      
    end
    
    ----------
    -- Draw --
    ----------
    function system:Draw(_pEntity)
      local emitter   = _pEntity:GetComponent(te)
      local renderer  = _pEntity:GetComponent(sr)
      local transform = _pEntity:GetComponent(tr)
      
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
        
        renderer  = _pEntity:GetComponent(an)
        if(renderer ~= nil) then
          
        end        
      end
    end
    
    return system 
  end
}