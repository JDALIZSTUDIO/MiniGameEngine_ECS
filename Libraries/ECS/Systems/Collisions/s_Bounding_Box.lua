return {
    new = function()
      local system = p_System.new({"transform", "boundingBox"})
      
      local layer      = {}
      local tileWidth  = 0
      local tileHeight = 0
      local deltaTime  = 0
      
      local bb = "boundingBox"
      local tr = "transform"

      ----------
      -- Load --
      ----------
      function system:Load(_pEntity)
        local bBox = _pEntity:Get_Component(bb)
              bBox:Load()
              
        if(isDebug) then print("Systems, loaded:      s_Bounding_Box by ".._pEntity.name) end
      end
      
      ------------
      -- Update --
      ------------
      function system:Update(dt, _pEntity)
        local bBox = _pEntity:Get_Component(bb)
        if(bBox.active == false) then return end

        local transform = _pEntity:Get_Component(tr)
        bBox:Update_Bounding_Box(transform)       
      end
      
      return system
    end  
  }