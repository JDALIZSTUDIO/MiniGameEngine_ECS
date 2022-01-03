return {
  new = function()
    local factoryEntity = Locator:Get_Service("f_entity")
    local Class = {
      expired   = false,
      entities  = {},
      systems   = {},
      z_sorting = false
    }

    local p      = "player"
    local bb     = "boundingBox"
    
    local insert = table.insert
    local remove = table.remove
    local sort   = table.sort
    local lstSorted

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
      local entity = factoryEntity.new()
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

    ----------------
    -- Pause_Game --
    ----------------
    function Class:Pause_Game()
      local ch = "characterController"
      for i = 1, #self.entities do  
        self.entities[i].active = false          
      end
    end

    
    -----------------
    -- Resume_Game --
    -----------------
    function Class:Resume_Game()
      local ch = "characterController"
      for i = 1, #self.entities do  
        self.entities[i].active = true          
      end
    end

    --------------
    -- Register --
    --------------
    function Class:Register(_pSystem)
      _pSystem.ECS = self
      insert(self.systems, _pSystem)
      return _pSystem
    end

    ---------------
    -- Set_Focus --
    ---------------
    function Class:Set_Focus(_pEntity)
      self.isFocus = true
      self.focus   = _pEntity
    end

    ---------------
    -- Z_Sorting --
    ---------------
    function Class:Sort_Entities(_pTable)
      sort(_pTable, Sort_Algo)
    end
    
    ---------------
    -- Sort_Algo --
    ---------------
    function Sort_Algo(_pEntityA, _pEntityB)
      local bBoxA = _pEntityA:Get_Component(bb)
      local bBoxB = _pEntityB:Get_Component(bb)
      if(bBoxA ~= nil and bBoxB ~= nil) then
        return bBoxA.bottom < bBoxB.bottom
      end
      return false
    end

    ------------
    -- Update --
    ------------
    function Class:Update(dt)
      -- UnLoad
      if(self.expired) then
        self.entities = {}
        self.systems  = {}
        self.expired  = false
      end

      -- Update
      lstSorted = {}
      local entity, focusID
      for i = #self.entities, 1, -1 do
        entity = self.entities[i]
        if(entity.expired) then
          for j, system in ipairs(self.systems) do
            if(system:Match(entity)) then
              system:Destroy(entity)
            end
          end

          entity:On_Destroy()
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
          if(self.z_sorting) then insert(lstSorted, entity) end
        end
      end

      -- Z_Sorting
      if(self.z_sorting) then self:Sort_Entities(lstSorted) end
    end

    ------------
    -- Unload --
    ------------
    function Class:UnLoad()
      self.expired = true
    end

    ----------
    -- Draw --
    ----------
    function Class:Draw()
      local entity
      local lstEntities
      if(self.z_sorting) then lstEntities = lstSorted else lstEntities = self.entities end
      for i = 1, #lstEntities do  
        entity = lstEntities[i]
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
      local entities = self.entities
      for i = 1, #entities do  
        entity = entities[i]
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