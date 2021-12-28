return {
  new = function() 
    local f_system = Locator:Get_Service("f_system")
    local system   = f_system.new({"transform"})
    
    local cos    = math.cos
    local sin    = math.sin
    local remove = table.remove

    local tr  = "transform"

    function system:Load(_pEntity)
      if(isDebug) then print("Systems, loaded:      s_Transform by ".._pEntity.name) end
    end
    
    function system:Update(dt, _pEntity)
      local transform = _pEntity:Get_Component(tr)
      
      local child, magnitude
      for i = #transform.children, 1, -1 do
        child = transform.children[i]
        if(child.expired) then 
          remove(transform.children, i)
        else
          if(child.transform.active) then
            magnitude = child.offset:Magnitude()
            child.transform.position:Set(
              transform.position.x + cos(transform.rotation+90) * magnitude,
              transform.position.y + sin(transform.rotation+90) * magnitude
            )
          end
        end
      end
    end
    
    return system 
  end
}