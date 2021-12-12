local ECS_Manager = {
  entities = {},
  systems  = {}
}

function ECS_Manager:Add(_pEntity)
  table.insert(self.entities, _pEntity)
  return _pEntity
end

function ECS_Manager:Create()
  local entity = p_Entity.new()
        entity.controller = self
        
  table.insert(self.entities, entity)
  return entity
end

function ECS_Manager:Find(_pName)
  local entity
  for i = 1, #self.entities do
    entity = self.entites[i]
    if(entity.name == _pName) then return entity end
  end
end


function ECS_Manager:Register(_pSystem)
  table.insert(self.systems, _pSystem)
end

function ECS_Manager:Update(dt)
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

function ECS_Manager:Draw()
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

return ECS_Manager