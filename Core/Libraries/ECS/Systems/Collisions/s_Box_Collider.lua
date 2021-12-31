return {
    new = function()
      local f_system = Locator:Get_Service("f_system")
      local system   = f_system.new({"transform", "boundingBox", "boxCollider"})
      
      local entities = {}      
      local bc       = "boxCollider"
      local bb       = "boundingBox"
      local ch       = "characterController"

      local insert = table.insert
      
      ----------------------
      -- Collide_Entities --
      ----------------------
      function system:Collide_Entities(_pEntity)        
        local length = #entities
        if(length < 2) then return end
  
        local result = {}
        local bBox   = _pEntity:Get_Component(bb)
        local boxCol = _pEntity:Get_Component(bc)
        
        if(bBox.active   == false or
           boxCol.active == false) then return end
        
        local otherBBox
        for i = length, 1, -1 do
          other = entities[i]        
          if(other ~= _pEntity and
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
        if(character ~= nil) then character:On_Collision_With_Entity(result) end          
      end

      ----------
      -- Load --
      ----------
      function system:Load(_pEntity)
        local bBox = _pEntity:Get_Component(bb)
              bBox:Load()
        
        entities = self.ECS:Get_Entities()

        if(isDebug) then print("Systems, loaded:      s_Box_Collider by ".._pEntity.name) end
      end
      
      ------------
      -- Update --
      ------------
      function system:Update(dt, _pEntity)
        self:Collide_Entities(_pEntity)
      end
      
      return system
    end  
  }