return {
    new = function(_pPower)
      local component = p_Component.new("fogRemover")
            component.power = _pPower or 128
    
      return component
    end
  }