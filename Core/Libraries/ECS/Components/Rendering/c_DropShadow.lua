return {
  new = function(_pOffsetX, _pOffsetY)
    local component = p_Component.new("dropShadow")
          component.alpha  = 0.3
          component.offset = Vector2.new(_pOffsetX or 1, _pOffsetY or 1)

    return component
  end
}