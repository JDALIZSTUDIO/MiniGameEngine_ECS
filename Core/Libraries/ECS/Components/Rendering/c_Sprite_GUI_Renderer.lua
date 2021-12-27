return {
    new = function(_pSprite, _pShader)
      local component = p_Component.new("spriteGUIRenderer")
            component.alpha       = 1
            component.isGUI       = false
            component.sprite      = _pSprite
            component.shader      = _pShader or nil
            component.surfacePing = nil
            component.surfacePong = nil
            
            function component:SetShader(_pShader)
              self.shader = _pShader
            end
        
      return component
    end
  }