return {
  new = function() 
    local f_system = Locator:Get_Service("f_system")
    local system   = f_system.new({"transform", "boundingBox", "trailEmitter"})

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
      local emitter = _pEntity:Get_Component(te)
      if(emitter.active == false) then return end
      
      emitter:Update(dt, _pEntity)
      
    end
    
    ----------
    -- Draw --
    ----------
    function system:Draw(_pEntity)
      local emitter   = _pEntity:Get_Component(te)
      local renderer  = _pEntity:Get_Component(sr)
      local transform = _pEntity:Get_Component(tr)
      
      if(emitter.active == false) then return end
      if(renderer.active == false) then return end
      
      if(renderer ~= nil) then
        local length = #emitter.trail
          if(length < 1) then return end
          
          local alpha, pos
          for i = 1, length do            
            alpha = i / length * renderer.alpha * 0.2
            love.graphics.setColor(0.5, 0.5, 0.5, alpha)
            
            trail = emitter.trail[i]
            love.graphics.draw(
              renderer.sprite.image, 
              trail.x, 
              trail.y, 
              math.rad(trail.rotation), 
              transform.scale.x, 
              transform.scale.y, 
              renderer.sprite.halfW, 
              renderer.sprite.halfH,
              0,
              0
            )
        end
        
        renderer  = _pEntity:Get_Component(an)
        if(renderer ~= nil) then
          
        end        
      end
    end
    
    return system 
  end
}