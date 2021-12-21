return {
    new = function()
      local component = p_Component.new("boxCollider")
            component.isTrigger = false
    
      local gameObject = nil
  
      local round = Round
     
      ------------
      -- Update --
      ------------
      function component:Load()
        gameObject = self.gameObject
      end
  
      ------------
      -- Update --
      ------------
      function component:Update(dt) 
        
      end     
  
      return component  
    end
  }