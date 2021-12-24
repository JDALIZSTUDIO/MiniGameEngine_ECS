return {
  new = function()
    local Class = {
      entities = {},
      systems  = {}
    }

    local insert = table.insert
    local remove = table.remove

    ---------
    -- Add --
    ---------
    function Class:Add(_pEntity)
      insert(self.entities, _pEntity)
      return _pEntity
    end

    ------------
    -- Create --
    ------------
    function Class:Create()
      local entity = p_Entity.new()
            entity.ECS = self
            
      insert(self.entities, entity)
      return entity
    end

    ----------
    -- Find --
    ----------
    function Class:Find(_pName)
      local entity
      local length = #self.entities
      if(length < 1) then return nil end
      for i = 1, length do
        entity = self.entities[i]
        if(entity.name == _pName) then return entity end
      end
    end

    ------------------
    -- Get_Entities --
    ------------------
    function Class:Get_Entities()
      return self.entities
    end

    ----------
    -- Load --
    ----------
    function Class:Load()
      
    end

    --------------
    -- Register --
    --------------
    function Class:Register(_pSystem)
      _pSystem.ECS = self
      insert(self.systems, _pSystem)
      return _pSystem
    end

    function Class:Z_Sorting()
      local temp = {}
      local entity
      for i = #self.entities, 1, -1 do
        entity = self.entities[i]
        insert(temp, entity)
      end
    end

    ------------
    -- Update --
    ------------
    function Class:Update(dt)
      local entity
      for i = #self.entities, 1, -1 do
        entity = self.entities[i]
        if(entity.expired) then
          for j, system in ipairs(self.systems) do
            if(system:Match(entity)) then
              system:Destroy(entity)
            end
          end
          
          remove(self.entities, i) 
        else      
          for j, system in ipairs(self.systems) do
            if(system:Match(entity)) then
              if(entity.loaded == false) then
                system:Load(entity)
              end          
              
              system:Update(dt, entity)
            end
          end
          
          entity.loaded = true
        end
      end
    end

    ----------
    -- Draw --
    ----------
    function Class:Draw()
      local entity
      for i = 1, #self.entities do  
        entity = self.entities[i]
        for j, system in ipairs(self.systems) do
          if(system:Match(entity)) then        
            system:Draw(entity)
          end
        end  
      end
    end

    --------------
    -- Draw_GUI --
    --------------
    function Class:Draw_GUI()
      local entity
      for i = 1, #self.entities do  
        entity = self.entities[i]
        for j, system in ipairs(self.systems) do
          if(system:Match(entity)) then        
            system:Draw_GUI(entity)
          end
        end  
      end
    end

    return Class
  end
}