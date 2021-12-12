return {
  new = function(_pPath, _pShader)
    local sR = p_Component.new("spriteRenderer")
      sR.sprite      = love.graphics.newImage(_pPath)
      sR.width       = sR.sprite:getWidth()
      sR.height      = sR.sprite:getHeight()
      sR.halfW       = sR.width  * 0.5
      sR.halfH       = sR.height * 0.5
      sR.shader      = _pShader or nil
      sR.surfacePing = nil
      sR.surfacePong = nil
      
      function sR:SetShader(_pShader)
        self.shader = _pShader
      end
      
    return sR
  end
}