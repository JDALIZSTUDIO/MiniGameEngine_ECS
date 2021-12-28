return {
  new = function(_pX, _pY, _pRotation)
    local f_component           = Locator:Get_Service("f_component")
    local component             = f_component.new("transform")
          component.children    = {}
          component.direction   = 0
          component.maxSpeed    = 180
          component.origin      = Vector2.new(_pX or 0, _pY or 0)
          component.parent      = nil
          component.position    = Vector2.new(_pX or 0, _pY or 0)
          component.rotation    = _pRotation or 0
          component.scale       = Vector2.new(1, 1)
          component.velocity    = Vector2.new(0, 0)
          component.velocityPre = Vector2.new(0, 0)
    
    local insert = table.insert
    local remove = table.remove

    ---------------
    -- Add_Child --
    ---------------
    function component:Add_Child(_pTransform, _pOffsetX, _pOffsetY)

      _pTransform.parent = self

      local child = {
        transform = _pTransform,
        offset    = Vector2.new(_pOffsetX or 0, _pOffsetY or 0)
      }
      
      insert(self.children, child)
    end
    
    -----------------------
    -- Get_Cell_Position --
    -----------------------
    function component:Get_Cell_Position(_pTileW, _pTileH)
      local transform = self.gameObject:Get_Component("transform")
      return {
          x = floor(self.position.x / _pTileW) + 1,
          y = floor(self.position.y / _pTileH) + 1
      }
    end

    ---------------
    -- Get_Child --
    ---------------
    function component:Get_Child(_pIndex)
      return self.children[_pIndex]
    end

    ------------------
    -- Remove_Child --
    ------------------
    function component:Remove_Child(_pTransform)
      local child
      for i = 1, #self.children do
        child = self.children[i]
        if(child.transform == _pTransform) then
          _pTransform.parent = nil
          remove(self.children, i)
          return true
        end
      end
      return false
    end

    return component
    
  end
}
