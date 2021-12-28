return {
  new = function(_pOffsetX, _pOffsetY, _pWidth, _pHeight)
    local f_component         = Locator:Get_Service("f_component")
    local component           = f_component.new("boundingBox")
          component.drawMode  = 'line'
          component.top       = 0
          component.bottom    = 0
          component.left      = 0
          component.right     = 0
          component.width     = _pWidth  or 0
          component.height    = _pHeight or 0
          component.halfW     = math.floor(component.width  * 0.5)
          component.halfH     = math.floor(component.height * 0.5)
          component.offset    = Vector2.new(_pOffsetX or 0, _pOffsetY or 0)
          component.position  = Vector2.new(0, 0)
    
    local gameObject = nil

    local round = Round
    local floor = math.floor

    ----------  
    -- Load --
    ----------
    function component:Load()
      gameObject = self.gameObject
    end

    --------------
    -- Contains --
    --------------
    function component:Contains(_pX, _pY)
      return (_pX >= self.left  and
              _pY >= self.top   and
              _pX <  self.right and
              _pY <  self.bottom)
    end

    ----------------
    -- Intersects --
    ----------------
    function component:Intersects(_pOtherBox)
      return (self.left   < _pOtherBox.right  and
              self.right  > _pOtherBox.left   and
              self.top    < _pOtherBox.bottom and
              self.bottom > _pOtherBox.top)
    end

    -------------------------
    -- Update_Bounding_Box --
    -------------------------
    function component:Update_Bounding_Box(_pTransform) 
      self.position.x = floor(_pTransform.position.x + self.offset.x)
      self.position.y = floor(_pTransform.position.y + self.offset.y)
      self.top        = floor(self.position.y - (self.halfH * _pTransform.scale.y))
      self.bottom     = floor(self.position.y + (self.halfH * _pTransform.scale.y))
      self.left       = floor(self.position.x - (self.halfW * _pTransform.scale.x))
      self.right      = floor(self.position.x + (self.halfW * _pTransform.scale.x))
    end     

    return component  
  end
}