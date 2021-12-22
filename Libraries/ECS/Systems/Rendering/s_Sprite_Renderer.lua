return {
  new = function()
    local system = p_System.new({"transform", "spriteRenderer"})
    
    local ds = "dropShadow"
    local sr = "spriteRenderer"
    local tr = "transform"
    
    ----------
    -- Load --
    ----------
    function system:Load(_pEntity)
      if(isDebug) then print("Systems, loaded:      Sprite_Renderer by ".._pEntity.name) end
    end
    
    ----------
    -- Draw --
    ----------
    function system:Draw(_pEntity)
      local dropShadow   = _pEntity:Get_Component(ds)
      local transform    = _pEntity:Get_Component(tr)
      local renderer     = _pEntity:Get_Component(sr)      
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