return {
  new = function()
    local Controller = {
      entities = {},
      systems  = {}
    }

    function Controller:Add(_pEntity)
      table.insert(self.entities, _pEntity)
      return _pEntity
    end

    function Controller:Create()
      local entity = p_Entity.new()
            entity.controller = self
            
      table.insert(self.entities, entity)
      return entity
    end

    function Controller:Find(_pName)
      local entity
      local length = #self.entities
      if(length < 1) then return nil end
      for i = 1, length do
        entity = self.entities[i]
        if(entity.name == _pName) then return entity end
      end
    end

    function Controller:Load()
      
    end

    function Controller:Register(_pSystem)
      table.insert(self.systems, _pSystem)
      return _pSystem
    end

    function Controller:Update(dt)
      local entity
      for i = #self.entities, 1, -1 do
        entity = self.entities[i]
        if(entity.expired) then
          for j, system in ipairs(self.systems) do
            if(system:Match(entity)) then
              system:Destroy(entity)
            end
          end
          
          table.remove(self.entities, i) 
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

    function Controller:Draw()
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

    return Controller
  end
}