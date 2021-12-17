return {
  new = function() 
    local system = p_System.new({"transform"})
    function system:Load(_pEntity)
      if(isDebug) then print("Systems, loaded:      s_Mover by ".._pEntity.name) end
    end
    
    function system:Update(dt, _pEntity)
      local transform = _pEntity:GetComponent("transform")
      
      transform.velocity:Clamp(transform.maxSpeed)
      transform.position.x = transform.position.x + transform.velocity.x * dt
      transform.position.y = transform.position.y + transform.velocity.y * dt
    end
    
    return system 
  end
}