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
      emitter:Update(dt)      
    end
    
    ----------
    -- Draw --
    ----------
    function system:Draw(_pEntity)
      local emitter = _pEntity:Get_Component(te)      
      emitter:Draw()
      
      love.graphics.setColor(1, 1, 1, 1)
    end
    
    return system 
  end
}