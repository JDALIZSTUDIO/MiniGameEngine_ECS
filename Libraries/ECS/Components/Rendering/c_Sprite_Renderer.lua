return {
  new = function(_pPath, _pShader)
    local component = p_Component.new("spriteRenderer")
          component.alpha       = 1
          component.isGUI       = false
          component.sprite      = love.graphics.newImage(_pPath)
          component.width       = component.sprite:getWidth()
          component.height      = component.sprite:getHeight()
          component.halfW       = component.width  * 0.5
          component.halfH       = component.height * 0.5
          component.shader      = _pShader or nil
          component.surfacePing = nil
          component.surfacePong = nil
          
          function component:SetShader(_pShader)
            self.shader = _pShader
          end
      
    return component
  end
}