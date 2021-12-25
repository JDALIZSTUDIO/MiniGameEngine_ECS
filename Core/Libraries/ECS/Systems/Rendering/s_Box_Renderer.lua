return {
  new = function()
    local system = p_System.new({"transform", "boundingBox", "boxRenderer"})
    
    local br = "boxRenderer"
    local bc = "boundingBox"
    local tr = "transform"

    ----------
    -- Load --
    ----------
    function system:Load(_pEntity)
      if(isDebug) then print("Systems, loaded:      s_Box_Renderer by ".._pEntity.name) end
    end
    
    ----------
    -- Draw --
    ----------
    function system:Draw(_pEntity)
      local renderer = _pEntity:Get_Component(br)
      if(renderer.active == false) then return end
      
      local bBox = _pEntity:Get_Component(bc)
      
      love.graphics.setColor(1, 0, 0, 1)
      love.graphics.rectangle(bBox.drawMode, 
                              bBox.left, 
                              bBox.top, 
                              bBox.width, 
                              bBox.height)
                            
      local transform = _pEntity:Get_Component(tr)
      love.graphics.circle(bBox.drawMode, bBox.position.x, bBox.position.y, 1)
      love.graphics.setColor(1, 1, 1, 1)
    end
    
    return system  
  end
}