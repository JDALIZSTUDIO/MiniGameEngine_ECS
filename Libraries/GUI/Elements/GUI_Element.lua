return {
  new = function(_pX, _pY)
    local element = {
      active      = true,
      alpha       = 1,
      expired     = false,
      x           = _pX,
      y           = _pY,
      sX          = 1,
      sY          = 1,
      sTarget     = 1.2,
      rotation    = 0,
      lerpSpeed   = 0.2,
    }
   
    return element
  end  
}