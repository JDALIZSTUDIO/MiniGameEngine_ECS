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

    function Entity:AddComponent(_pComponent)
      assert(_pComponent.__id)
      self.components[_pComponent.__id] = _pComponent
      return _pComponent
    end

    function Entity:GetComponent(_pID)
      return self.components[_pID]
    end

    function Entity:Destroy()
      self.expired = true
    end

    function Entity:Load()
      
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