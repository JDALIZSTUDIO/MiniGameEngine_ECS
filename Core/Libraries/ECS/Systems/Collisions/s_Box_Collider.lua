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
  
        local bBox   = _pEntity:Get_Component(bb)
        local boxCol = _pEntity:Get_Component(bc)
        local otherBBox
        
        local collide = false
        local result  = {}
        
        for i = length, 1, -1 do
          other = entities[i]        
          if(other ~= _pEntity      and
             other.active  == true) then
             
            if(system:Match(other)) then
              otherBBox = other:Get_Component(bb)
              if(bBox:Intersects(otherBBox)) then
                collide = true
                insert(result, other)
              end
            end
          end
        end 
        
        if(collide) then
          local character = _pEntity:Get_Component(ch)
          if(character ~= nil) then character:On_Entity_Collision(result) end
        end      
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
        local bBox = _pEntity:Get_Component(bb)
        if(bBox.active == false) then return end
        self:Collide_Entities(_pEntity)
      end
      
      return system
    end  
  }