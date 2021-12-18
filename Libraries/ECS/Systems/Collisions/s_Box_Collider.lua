return {
    new = function()
      local system = p_System.new({"transform", "boxCollider"})
      
      local layer      = {}
      local tileWidth  = 0
      local tileHeight = 0
      local deltaTime  = 0
      
      ----------
      -- Load --
      ----------
      function system:Load(_pEntity)
        if(isDebug) then print("Systems, loaded:      s_Box_Collider by ".._pEntity.name) end
      end
      
      ------------
      -- Update --
      ------------
      function system:Update(dt, _pEntity)
        local transform = _pEntity:GetComponent("transform")
        local collider  = _pEntity:GetComponent("boxCollider")
        if(collider.active == false) then return end        
        system:UpdateBoxCollider(transform, collider)        
      end
      
      ------------------------
      -- UpdateBoxCollider --
      ------------------------
      function system:UpdateBoxCollider(_pTransform, _pCollider) 
        _pCollider.position.x = Round(_pTransform.position.x + _pCollider.offset.x)
        _pCollider.position.y = Round(_pTransform.position.y + _pCollider.offset.y)
        _pCollider.top        = Round(_pCollider.position.y - ((_pCollider.height * 0.5) * _pTransform.scale.y))
        _pCollider.bottom     = Round(_pCollider.position.y + ((_pCollider.height * 0.5) * _pTransform.scale.y))
        _pCollider.left       = Round(_pCollider.position.x - ((_pCollider.width  * 0.5) * _pTransform.scale.x))
        _pCollider.right      = Round(_pCollider.position.x + ((_pCollider.width  * 0.5) * _pTransform.scale.x))
      end
      
      return system
    end  
  }