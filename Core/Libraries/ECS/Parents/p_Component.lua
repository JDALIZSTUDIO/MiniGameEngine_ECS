return {
  new = function(_pID)
    assert(_pID)
    local component = {__id = _pID, active = true, gameObject = nil}
    return component
  end
  
}