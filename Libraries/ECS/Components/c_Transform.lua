return {
  new = function(_pX, _pY, _pRotation)
    local transform = p_Component.new("transform")
          transform.position    = Vector2:New(_pX or 0, _pY or 0)
          transform.rotation    = _pRotation or 0
          transform.scale       = Vector2:New(1, 1)
          transform.velocity    = Vector2:New(0, 0)
          transform.velocityPre = Vector2:New(0, 0)
        
    return transform
    
  end
}
