return {
  new = function(_pColor, _pPower)
    local component = p_Component.new("lightSource")
          component.color = _pColor or {1, 1, 1}
          component.power = _pPower or 64
  
  return component
  end
}