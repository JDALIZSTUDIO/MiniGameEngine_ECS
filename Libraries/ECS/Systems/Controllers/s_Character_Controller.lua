return {
  new = function() 
    local system = p_System.new({"characterController"})
    
    local ch = "characterController"
    
    function system:Load(_pEntity)
      local controller = _pEntity:Get_Component(ch)
            controller:Load(_pEntity)
      if(isDebug) then print("Systems, loaded:      s_Character_Controller by ".._pEntity.name) end
    end
    
    function system:Update(dt, _pEntity)
      local controller = _pEntity:Get_Component(ch)
            controller:Update(dt, _pEntity)
    end
    
    function system:Draw(_pEntity)
      local controller = _pEntity:Get_Component(ch)
            controller:Draw(_pEntity)
    end
    
    return system 
  end
}