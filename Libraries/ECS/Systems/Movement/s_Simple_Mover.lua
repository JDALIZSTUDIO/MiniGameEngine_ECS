return {
  new = function() 
    local system = p_System.new({"transform"})
    
    local cos = math.cos
    local sin = math.sin
    local tr  = "transform"

    function system:Load(_pEntity)
      if(isDebug) then print("Systems, loaded:      s_Simple_Mover by ".._pEntity.name) end
    end
    
    function system:Update(dt, _pEntity)
      local transform = _pEntity:Get_Component(tr)
      
      transform.velocity:Clamp(transform.maxSpeed)

      local direction      = transform.velocity:Direction()
      local magnitude      = transform.velocity:Length()
      local dX             = cos(direction) * magnitude
      local dY             = sin(direction) * magnitude
      transform.position.x = transform.position.x + (dX * dt)
      transform.position.y = transform.position.y + (dY * dt)
    end
    
    return system 
  end
}