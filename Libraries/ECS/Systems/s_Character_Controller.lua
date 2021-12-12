return {
  new = function() 
    local system = p_System.new({"characterController"})
    
    local id = "characterController"
    
    function system:Load(_pEntity)
      local controller = _pEntity:GetComponent(id)
            controller:Load(_pEntity)
      if(debug) then print("Systems, loaded:      s_Character_Controller by ".._pEntity.name) end
    end
    
    function system:Update(dt, _pEntity)
      local controller = _pEntity:GetComponent(id)
            controller:Update(dt, _pEntity)
    end
    
    function system:Draw(_pEntity)
      local controller = _pEntity:GetComponent(id)
            controller:Draw(_pEntity)
    end
    
    return system 
  end
}