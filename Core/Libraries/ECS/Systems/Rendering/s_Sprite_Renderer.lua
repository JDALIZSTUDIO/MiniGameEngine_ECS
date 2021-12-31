return {
  new = function()
    local f_system = Locator:Get_Service("f_system")
    local system   = f_system.new({"transform", "spriteRenderer"})
    
    local ds = "dropShadow"
    local sr = "spriteRenderer"
    local tr = "transform"

    local rad = math.rad
    
    ----------
    -- Load --
    ----------
    function system:Load(_pEntity)
      local renderer = _pEntity:Get_Component(sr) 
            renderer:Load()

      if(isDebug) then print("Systems, loaded:      Sprite_Renderer by ".._pEntity.name) end
    end
    
    ----------
    -- Draw --
    ----------
    function system:Draw(_pEntity)
      local renderer   = _pEntity:Get_Component(sr)      
      if(renderer.active == false) then return end
      
      local dropShadow = _pEntity:Get_Component(ds)
      local transform  = _pEntity:Get_Component(tr)
      if(dropShadow ~= nil) then
        renderer:Draw_Dropshadow(transform, dropShadow)
      end      
      renderer:Draw(transform)
    end
    
    return system  
  end
}