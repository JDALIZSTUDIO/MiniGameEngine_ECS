return {
  new = function(_pX, _pY, _pRotation)
    local component = p_Component.new("transform")
          component.direction   = 0
          component.maxSpeed    = 180
          component.origin      = Vector2.new(_pX or 0, _pY or 0)
          component.position    = Vector2.new(_pX or 0, _pY or 0)
          component.rotation    = _pRotation or 0
          component.scale       = Vector2.new(1, 1)
          component.velocity    = Vector2.new(0, 0)
          component.velocityPre = Vector2.new(0, 0)
        
    return component
    
  end
}
