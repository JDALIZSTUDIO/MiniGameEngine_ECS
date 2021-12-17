return {
  new = function()
    local system = p_System.new({"transform", "childOf"})
  
    function system:Load(_pEntity)
      if(isDebug) then print("Systems, loaded:      ChildOf by ".._pEntity.name) end
    end
    
    function system:Update(dt, _pEntity)
      local childOf     = _pEntity:GetComponent("childOf")
      if(childOf.active == false) then return end
      
      local transform = _pEntity:GetComponent("transform")
      local distance  = childOf.offset:Length()
      
      local x = childOf.parent.position.x + Cos(childOf.parent.rotation+90) * distance
      local y = childOf.parent.position.y + Sin(childOf.parent.rotation+90) * distance
      
      transform.position:Set(x, y)
      transform.rotation = childOf.parent.rotation
      
    end
    
    return system  
  end
}