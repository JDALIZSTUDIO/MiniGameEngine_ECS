return {
  new = function(_pColor, _pPower)
    local component = p_Component.new("lightSource")
          component.color  = _pColor or {1, 1, 1}
          component.power  = _pPower or 32
  
    return component
  end
}