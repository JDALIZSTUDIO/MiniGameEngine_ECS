return {
    new = function()
      local system = p_System.new({"transform", "boundingBox"})
      
      local layer      = {}
      local tileWidth  = 0
      local tileHeight = 0
      local deltaTime  = 0
      
      local bc = "boundingBox"
      local tr = "transform"

      ----------
      -- Load --
      ----------
      function system:Load(_pEntity)
        local collider  = _pEntity:GetComponent(bc)
              collider:Load()
              
        if(isDebug) then print("Systems, loaded:      s_Box_Collider by ".._pEntity.name) end
      end
      
      ------------
      -- Update --
      ------------
      function system:Update(dt, _pEntity)
        local collider  = _pEntity:GetComponent(bc)
        if(collider.active == false) then return end

        local transform = _pEntity:GetComponent(tr)
        collider:Update_Collider(transform)       
      end
      
      return system
    end  
  }