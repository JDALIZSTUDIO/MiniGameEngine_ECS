return {
  new = function(_pID)
    assert(_pID)
    local component = {__id = _pID, active = true}
    return component
  end
  
}