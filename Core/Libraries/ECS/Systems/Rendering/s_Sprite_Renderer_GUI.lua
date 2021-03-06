return {
    new = function()
      local f_system = Locator:Get_Service("f_system")
      local system   = f_system.new({"transform", "spriteRendererGUI"})
      
      local ds = "dropShadow"
      local sr = "spriteRendererGUI"
      local tr = "transform"
      
      ----------
      -- Load --
      ----------
      function system:Load(_pEntity)
        if(isDebug) then print("Systems, loaded:      Sprite_GUI_Renderer by ".._pEntity.name) end
      end
      
      --------------
      -- Draw_GUI --
      --------------
      function system:Draw_GUI(_pEntity)
        local dropShadow   = _pEntity:Get_Component(ds)
        local transform    = _pEntity:Get_Component(tr)
        local renderer     = _pEntity:Get_Component(sr)      
        if(renderer.active == false) then return end
        
        if(renderer.shader ~= nil) then 
          if(renderer.shader.active) then renderer.shader:Set() end 
        end
        
        if(dropShadow ~= nil) then
          love.graphics.setColor(0, 0, 0, dropShadow.alpha * renderer.alpha)
        
          love.graphics.draw(
            renderer.sprite.image, 
            transform.position.x + dropShadow.offset.x, 
            transform.position.y + dropShadow.offset.y, 
            math.rad(transform.rotation), 
            transform.scale.x, 
            transform.scale.y, 
            renderer.sprite.halfW, 
            renderer.sprite.halfH,
            0,
            0
          )
        end
        
        love.graphics.setColor(1, 1, 1, renderer.alpha)
        
        love.graphics.draw(
          renderer.sprite.image, 
          transform.position.x, 
          transform.position.y, 
          math.rad(transform.rotation), 
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