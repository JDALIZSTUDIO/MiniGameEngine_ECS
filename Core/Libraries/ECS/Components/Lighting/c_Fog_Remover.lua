return {
    new = function(_pPower)
      local f_component     = Locator:Get_Service("f_component")
      local component       = f_component.new("fogRemover")
            component.power = _pPower or 256
    
      return component
    end
  }