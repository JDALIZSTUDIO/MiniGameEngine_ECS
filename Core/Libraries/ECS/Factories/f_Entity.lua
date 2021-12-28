return {
  new = function()
    local Entity = {
      active     = true,
      components = {},
      controller = nil,
      expired    = false,
      loaded     = false,
      tags       = {},
      name       = "default"
    }

    function Entity:Add_Component(_pComponent)
      assert(_pComponent.__id)
      self.components[_pComponent.__id] = _pComponent
      self.components[_pComponent.__id].gameObject = self
      return _pComponent
    end

    function Entity:Get_Component(_pID)
      return self.components[_pID]
    end

    function Entity:Destroy()
      Entity.expired = true
    end

    function Entity:Load()
      
    end

    function Entity:On_Destroy()
       local controller = self:Get_Component("characterController")
       if(controller ~= nil) then controller:On_Destroy() end
    end

    function Entity:Update(dt)
      local components = self.components["update"]
      for i = 1, #components do
        components[i]:Update(dt)
      end
    end

    function Entity:Draw()
      local components = self.components["draw"]
      for i = 1, #components do
        components[i]:Draw()
      end
    end

    return Entity
  end

}