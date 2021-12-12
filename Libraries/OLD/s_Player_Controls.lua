return {
  new = function()
    local system = p_System.new({"playerControls"})
  
    function system:Load(_pEntity)
      if(debug) then print("Systems, loaded:      s_Input by ".._pEntity.name) end
    end
    
    function system:Update(_pEntity)
      local input = _pEntity:GetComponent("input")
            input:Update(dt, _pEntity)
    end
    
    return system    
  end  
}