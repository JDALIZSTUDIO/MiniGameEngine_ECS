return {
  new = function()
    local system = p_System.new({"transform", "boundingBox"})
    
    local entities   = {}
    local deltaTime  = 0
    
    local bc         = "boundingBox"
    local ch         = "characterController"
    local tr         = "transform"
    local insert     = table.insert

    ----------
    -- Load --
    ----------
    function system:Load(_pEntity)
      if(isDebug) then print("Systems, loaded:      s_Entity_Collider by ".._pEntity.name) end
    end
    
    -----------------
    -- SetEntities --
    -----------------
    function system:SetEntities(_pEntities)
      entities = _pEntities
    end
    
    ------------
    -- Update --
    ------------
    function system:Update(dt, _pEntity)
      local collider  = _pEntity:Get_Component(bc)
      if(collider.active == false) then return end
      
      deltaTime = dt
      local transform = _pEntity:Get_Component(tr)
      system:EntityCollisions(_pEntity)
      
    end
    
    ----------------------
    -- EntityCollisions --
    ----------------------
    function system:EntityCollisions(_pEntity)
      local length = #entities
      if(length < 2) then print("no_entities_to_collide_with") return end

      local collider = _pEntity:Get_Component(bc)

      local result   = {}
      
      for i = length, 1, -1 do
        other = entities[i]        
        if(other ~= _pEntity      and 
           other.expired == false and
           other.active  == true) then
           
          if(system:Match(other)) then
            if(collider:Intersects(other)) then 
              insert(result, other)
            end
          end
        end
      end 
      
      local character = _pEntity:Get_Component(ch)
      if(character ~= nil) then character:OnEntityCollision(result) end
      
    end
    
    return system
  end  
}