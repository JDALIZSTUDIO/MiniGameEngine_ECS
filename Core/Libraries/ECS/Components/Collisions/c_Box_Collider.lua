return {
    new = function()
      local component = p_Component.new("boxCollider")
            component.isTrigger = false
         
      ------------
      -- Update --
      ------------
      function component:Load()
        
      end
  
      ------------
      -- Update --
      ------------
      function component:Update(dt) 
        
      end     
  
      return component  
    end
  }