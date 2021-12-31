return {
  new = function(_pSprite, _pShaders)
    local f_component           = Locator:Get_Service("f_component")
    local component             = f_component.new("spriteRenderer")
          component.alpha       = 1
          component.isGUI       = false
          component.sprite      = _pSprite
          component.shader      = nil
          component.shaders     = _pShaders or {}
          component.surface     = nil
          component.surfaces    = {
            nil,
            nil
          }          
    
    local rad       = math.rad
    local an = "spriteRenderer"
    local tr = "transform"
    local sr = "spriteRenderer" 

    ----------
    -- Load --
    ----------
    function component:Load()
      local surface
      for i = 0, #self.surfaces do
        surface = self.surfaces[i]
        surface = love.graphics.newCanvas(
          self.sprite.width,
          self.sprite.height
        )
        surface:setFilter("linear", "linear", 16)
      end
    end

    ---------------
    -- Set_Alpha --
    ---------------
    function component:Set_Alpha(_pValue)
      self.alpha = _pValue
      local transform = self.gameObject:Get_Component(tr)
      local cTransform, cRenderer, cAnimator
      for i = 1, #transform.children do
        cTransform = transform.children[i].transform
        cRenderer  = cTransform.gameObject:Get_Component(sr)
        if(cRenderer ~= nil) then cRenderer.alpha = self.alpha end
        cAnimator  = cTransform.gameObject:Get_Component(an)
        if(cAnimator ~= nil) then cAnimator.alpha = self.alpha end
      end
    end

    ----------------
    -- Set_Shader --
    ----------------
    function component:Set_Shader(_pShader)
      self.shader = _pShader
    end

    -----------------
    -- Set_Surface --
    -----------------
    function component:Set_Surface(_pIndex)
      self.surface = self.surfaces[_pIndex]
    end

    ----------
    -- Draw --
    ----------
    function component:Draw(_ptransform)
      if(self.shader ~= nil and self.shader.active) then self.shader:Set() end 

      love.graphics.setColor(1, 1, 1, self.alpha)      
      love.graphics.draw(
        self.sprite.image, 
        _ptransform.position.x, 
        _ptransform.position.y, 
        rad(_ptransform.rotation), 
        _ptransform.scale.x, 
        _ptransform.scale.y, 
        self.sprite.halfW, 
        self.sprite.halfH,
        0,
        0
      )

      if(self.shader ~= nil) then self.shader:UnSet() end
    end

    ---------------------
    -- Draw_Dropshadow --
    ---------------------
    function component:Draw_Dropshadow(_ptransform, _pShadow)
      love.graphics.setColor(0, 0, 0, _pShadow.alpha * self.alpha)      
      love.graphics.draw(
        self.sprite.image, 
        _ptransform.position.x + _pShadow.offset.x, 
        _ptransform.position.y + _pShadow.offset.y, 
        rad(_ptransform.rotation), 
        _ptransform.scale.x, 
        _ptransform.scale.y, 
        self.sprite.halfW, 
        self.sprite.halfH,
        0,
        0
      )
    end
      
    return component
  end
}