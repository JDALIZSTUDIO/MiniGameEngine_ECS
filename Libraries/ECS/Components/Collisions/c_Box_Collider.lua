return {
  new = function(_pOffsetX, _pOffsetY, _pWidth, _pHeight)
    local bBox = p_Component.new("boxCollider")
          bBox.drawMode      = 'line'
          bBox.isTrigger     = true
          bBox.isKinematic   = false
          bBox.top           = 0
          bBox.bottom        = 0
          bBox.left          = 0
          bBox.right         = 0
          bBox.width         = _pWidth or 0
          bBox.height        = _pHeight or 0
          bBox.offset        = Vector2.new(_pOffsetX or 0, _pOffsetY or 0)
          bBox.position      = Vector2.new(0, 0)
    
    return bBox  
  end
}