return {
  new = function()
    local system = p_System.new({"transform", "boundingBox", "boxRenderer"})
  
    function system:Load(_pEntity)
      if(debug) then print("Systems, loaded:      Physics by ".._pEntity.name) end
    end
    
    function system:Draw(_pEntity)      
      if(debug) then
        local bBox = _pEntity:GetComponent("boundingBox")
        love.graphics.rectangle(bBox.drawMode, 
                                bBox.left, 
                                bBox.top, 
                                bBox.width, 
                                bBox.height)
      end
    end
    
    return system  
  end
}