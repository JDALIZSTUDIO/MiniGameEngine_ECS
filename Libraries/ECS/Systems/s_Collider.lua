return {
  new = function(_pEntities)
    local system    = p_System.new({"transform", "boundingBox"})
    system.entities = _pEntities or {}
    
    function system:Load(_pEntity)
      if(debug) then print("Systems, loaded:      s_Collider by ".._pEntity.name) end
    end
    
    function system:Intersects(_pEntity, _pOther)
      local bb = "boundingBox"
      local bBoxA = _pEntity:GetComponent(bb)
      local bBoxB = _pOther:GetComponent(bb)
      
      if((bBoxB.position.x >= bBoxA.right)      or
         (bBoxB.right      <= bBoxA.position.x) or
         (bBoxB.position.y >= bBoxA.bottom)     or
         (bBoxB.bottom     <= bBoxA.position.y)) then
        return false
        
      else
        return true
        
      end
    end
    
    function system:Update(dt, _pEntity)
      system:UpdateboundingBox(_pEntity)
      system:UpdateCollisions(_pEntity)
    end
    
    function system:UpdateboundingBox(_pEntity)
      local transform = _pEntity:GetComponent("transform")
      local bBox      = _pEntity:GetComponent("boundingBox")    
      bBox.position.x = transform.position.x + bBox.offset.x
      bBox.position.y = transform.position.y + bBox.offset.y
      bBox.top        = bBox.position.y - (bBox.height * 0.5)
      bBox.bottom     = bBox.position.y + (bBox.height * 0.5)
      bBox.left       = bBox.position.x - (bBox.width  * 0.5)
      bBox.right      = bBox.position.x + (bBox.width  * 0.5)
    end
    
    function system:UpdateCollisions(_pEntity)
      local length = #system.entities
      if(length < 2) then return end
      
      -- clear the collisions table
      local bbox = _pEntity:GetComponent("boundingBox")
      for i = 1, #bbox.collisions do
        bbox.collisions[i] = nil
      end
      
      -- find entities to collide with    
      for i = length, 1, -1 do
        other = system.entities[i]        
        if(other ~= _pEntity      and 
           other.expired == false and
           other.active  == true) then
           
          if(system:Match(other)) then              
            if(system:Intersects(_pEntity, other)) then              
                table.insert(bbox.collisions, other)
            end
          end
        end
      end    
    end
    
    return system
  end  
}