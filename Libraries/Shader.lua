return {
  new = function(_pPath, _pActive)    
    local data = {
      active   = _pActive or true,
      shader   = love.graphics.newShader(_pPath),
      uniforms = {}
    }    
    
    function data:AddUniform(_pKey, _pValue)
      self.uniforms[_pKey] = _pValue
    end
    
    function data:GetUniform(_pKey)
      return self.uniforms[_pKey]
    end
    
    function data:SendUniforms()
      local uniform
      for key, value in pairs(self.uniforms) do
        self.shader:send(key, value)
        
      end
    end
    
    function data:SetUniform(_pKey, _pValue)
      self.uniforms[_pKey] = _pValue
    end
    
    function data:Set()
      love.graphics.setShader(self.shader)
      self:SendUniforms()
    end
    
    function data:UnSet()
      love.graphics.setShader()
    end
    
    return data
  end
}