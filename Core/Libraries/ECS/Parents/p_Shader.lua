return {
  new = function(_pPath, _pActive)    
    local data = {
      active   = _pActive or true,
      shader   = love.graphics.newShader(_pPath),
      uniforms = {}
    }    
    
    function data:AddUniform(_pKey, _pValue)
      local uniform = {
        key         = _pKey,
        value       = _pValue
      }
      
      table.insert(self.uniforms, uniform)
    end
    
    function data:GetUniform(_pKey)
      local uniform
      for i = 1, #self.uniforms do
        uniform = self.uniforms[i]
        if(uniform.key == _pKey) then return uniform.value end
      end      
      return nil
    end
    
    function data:SendUniforms()
      local uniform
      for i = 1, #self.uniforms do
        uniform = self.uniforms[i]
        self.shader:send(uniform.key, uniform.value)
      end
    end
    
    function data:SetUniform(_pKey, _pValue)
      local uniform
      for i = 1, #self.uniforms do
        uniform = self.uniforms[i]
        if(uniform.key == _pKey) then
          uniform.value = _pValue 
          return
        end
      end
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