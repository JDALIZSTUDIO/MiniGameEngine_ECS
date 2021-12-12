return {
  new = function(_pTransform, _pOffsetX, _pOffsetY)
    local Child = p_Component.new("childOf")
          Child.offset = Vector2:New(_pOffsetX or 0, _pOffsetY or 0)
          Child.parent = _pTransform
  
  return Child
  end
}