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
      
      if(dropShadow ~= nil) then
        love.graphics.setColor(0, 0, 0, dropShadow.alpha)
      
        love.graphics.draw(
          renderer.sprite.image, 
          transform.position.x + dropShadow.offset.x, 
          transform.position.y + dropShadow.offset.y, 
          rad(transform.rotation), 
          transform.scale.x, 
          transform.scale.y, 
          renderer.sprite.halfW, 
          renderer.sprite.halfH,
          0,
          0
        )
      end
      
      if(renderer.shader ~= nil) then 
        if(renderer.shader.active) then renderer.shader:Set() end 
      end
      
      love.graphics.setColor(1, 1, 1, renderer.alpha)
      
      love.graphics.draw(
        renderer.sprite.image, 
        transform.position.x, 
        transform.position.y, 
        rad(transform.rotation), 
        transform.scale.x, 
        transform.scale.y, 
        renderer.sprite.halfW, 
        renderer.sprite.halfH,
        0,
        0
      )
                       
      if(renderer.shader ~= nil) then renderer.shader:UnSet() end
    end
    
    return system  
  end
}