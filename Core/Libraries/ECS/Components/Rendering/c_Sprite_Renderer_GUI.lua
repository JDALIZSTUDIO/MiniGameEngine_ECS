return {
    new = function(_pSprite, _pShader)
      local f_component           = Locator:Get_Service("f_component")
      local component             = f_component.new("spriteRendererGUI")
            component.alpha       = 1
            component.isGUI       = false
            component.sprite      = _pSprite
            component.shader      = _pShader or nil
            component.surfacePing = nil
            component.surfacePong = nil
            
            function component:Set_Shader(_pShader)
              self.shader = _pShader
            end
        
      return component
    end
  }