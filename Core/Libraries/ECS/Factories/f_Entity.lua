return {
  new = function()
    local Class = {
      active     = true,
      components = {},
      controller = nil,
      ECS        = nil,
      expired    = false,
      loaded     = false,
      tags       = {},
      name       = "default"
    }

    -------------------
    -- Add_Component --
    -------------------
    function Class:Add_Component(_pComponent)
      assert(_pComponent.__id)
      self.components[_pComponent.__id] = _pComponent
      self.components[_pComponent.__id].gameObject = self
      return _pComponent
    end

    -------------------
    -- Get_Component --
    -------------------
    function Class:Get_Component(_pID)
      return self.components[_pID]
    end

    -------------
    -- Destroy --
    -------------
    function Class:Destroy()
      self.expired = true
    end
    
    ----------------------
    -- Destroy_Children --
    ----------------------
    function Class:Destroy_Children()
      local child
      local transform = self:Get_Component("transform")
      if(transform ~= nil) then
        for i = 1, #self.children do
          child = self.children[i].transform.gameObject
          child:Destroy()
        end
      end
    end

    ----------------
    -- Find_Other --
    ----------------
    function Class:Find_Other(_pName)
      local ECS = self.ECS
      local other = ECS:Find(_pName)
      if(other ~= nil) then
          return other
      end
      return nil
    end

    ----------
    -- Load --
    ----------
    function Class:Load()
      
    end

    ----------------
    -- On_Destroy --
    ----------------
    function Class:On_Destroy()
       local controller = self:Get_Component("characterController")
       if(controller ~= nil) then controller:On_Destroy() end
    end

    ------------
    -- Update --
    ------------
    function Class:Update(dt)
      local components = self.components["update"]
      for i = 1, #components do
        components[i]:Update(dt)
      end
    end

    ----------
    -- Draw --
    ----------
    function Class:Draw()
      local components = self.components["draw"]
      for i = 1, #components do
        components[i]:Draw()
      end
    end

    return Class
  end

}