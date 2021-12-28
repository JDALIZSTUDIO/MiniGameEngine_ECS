return {
  new = function(_pColor, _pPower)
    local f_component      = Locator:Get_Service("f_component")
    local component        = f_component.new("lightSource")
          component.color  = _pColor or {1, 1, 1}
          component.power  = _pPower or 32
  
    return component
  end
}