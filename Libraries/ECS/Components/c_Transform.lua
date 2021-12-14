return {
  new = function(_pX, _pY, _pRotation)
    local transform = p_Component.new("transform")
          transform.maxSpeed    = 180
          transform.origin      = Vector2.new(_pX or 0, _pY or 0)
          transform.position    = Vector2.new(_pX or 0, _pY or 0)
          transform.rotation    = _pRotation or 0
          transform.scale       = Vector2.new(1, 1)
          transform.velocity    = Vector2.new(0, 0)
          transform.velocityPre = Vector2.new(0, 0)
        
    return transform
    
  end
}
