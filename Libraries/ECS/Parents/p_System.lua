return {
  new = function(_pRequirements)
    assert(type(_pRequirements) == 'table')
    local system = {
      ECS        = nil,
      requires   = _pRequirements      
    }
    
    function system:Match(_pEntity) 
      for i = 1, #self.requires do
        if(_pEntity:GetComponent(self.requires[i]) == nil) then
          return false
        end
      end
      
      return true
    end
    
    function system:Load(_pEntity) end
    function system:Update(dt, _pEntity) end
    function system:Draw(_pEntity) end
    function system:UI_Draw(_pEntity) end
    function system:Destroy(_pEntity) end
    
    return system
  end
}