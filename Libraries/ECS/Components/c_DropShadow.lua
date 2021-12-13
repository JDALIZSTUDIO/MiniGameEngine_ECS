return {
  new = function(_pOffsetX, _pOffsetY)
    local dS = p_Component.new("dropShadow")
          dS.alpha  = 0.3
          dS.offset = Vector2:New(_pOffsetX or 1, _pOffsetY or 1)
      
    return dS
  end
}