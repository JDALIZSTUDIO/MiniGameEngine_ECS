return {
  new = function(_pECS)
    local CC = p_Component.new("characterController")
          CC.GameObject = _pECS or nil
    
      function CC:Load(_pEntity)
        
      end
      
      function CC:OnEntityCollision(_pEntity, _pTable)        
        
      end
      
      function CC:OnTileCollision(_pEntity, _pTileID)        
        
      end
      
      function CC:Update(dt, _pEntity)
        
      end
      
      function CC:Draw(_pEntity)
        
      end
    
    return CC
  end
}