return {
    new = function()
      local system = p_System.new({"transform", "boundingBox"})
      
      local entities = {}      
      local bc       = "boxCollider"
      local bb       = "boundingBox"
      
      ----------------------
      -- Collide_Entities --
      ----------------------
      function system:Collide_Entities(_pEntity)        
        local length = #entities
        if(length < 2) then return end
  
        local bBox   = _pEntity:Get_Component(bb)
        local boxCol = _pEntity:Get_Component(bc)
        local otherBBox
  
        local result   = {}
        
        for i = length, 1, -1 do
          other = entities[i]        
          if(other ~= _pEntity      and 
             other.expired == false and
             other.active  == true) then
             
            if(system:Match(other)) then
              otherBBox = other:Get_Component(bb)
              if(bBox:Intersects(otherBBox)) then
                insert(result, other)
              end
            end
          end
        end 
        
        local character = _pEntity:Get_Component(ch)
        if(character ~= nil) then character:On_Entity_Collision(result) end        
      end

      ----------
      -- Load --
      ----------
      function system:Load(_pEntity)
        local bBox = _pEntity:Get_Component(bb)
              bBox:Load()
        
        entities = self.ECS:Get_Entities()

        if(isDebug) then print("Systems, loaded:      s_Bounding_Box by ".._pEntity.name) end
      end
      
      ------------
      -- Update --
      ------------
      function system:Update(dt, _pEntity)
        local bBox = _pEntity:Get_Component(bb)
        if(bBox.active == false) then return end
        self:Collide_Entities(_pEntity)
      end
      
      return system
    end  
  }