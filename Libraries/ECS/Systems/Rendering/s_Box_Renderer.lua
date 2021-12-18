return {
  new = function()
    local system = p_System.new({"transform", "boxCollider", "boxRenderer"})
  
    function system:Load(_pEntity)
      if(isDebug) then print("Systems, loaded:      Box_Renderer by ".._pEntity.name) end
    end
    
    function system:Draw(_pEntity)
      local renderer = _pEntity:GetComponent("boxRenderer")
      if(renderer.active == false) then return end
      
      local bBox = _pEntity:GetComponent("boxCollider")
      
      love.graphics.setColor(1, 1, 1, 1)
      love.graphics.rectangle(bBox.drawMode, 
                              bBox.left, 
                              bBox.top, 
                              bBox.width, 
                              bBox.height)
                            
      local transform = _pEntity:GetComponent("transform")
      love.graphics.circle("fill", transform.position.x, transform.position.y, 1)
    end
    
    return system  
  end
}