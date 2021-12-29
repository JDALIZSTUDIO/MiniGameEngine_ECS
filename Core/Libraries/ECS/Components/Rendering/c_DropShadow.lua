return {
  new = function(_pOffsetX, _pOffsetY, _pAlpha)
    local f_component      = Locator:Get_Service("f_component")
    local component        = f_component.new("dropShadow")
          component.alpha  = _pAlpha or 0.3
          component.offset = Vector2.new(_pOffsetX or 1, _pOffsetY or 1)

    return component
  end
}