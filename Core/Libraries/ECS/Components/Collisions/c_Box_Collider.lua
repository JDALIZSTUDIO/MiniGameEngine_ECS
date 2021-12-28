return {
    new = function()
      local factory = Locator:Get_Service("f_component")
      local component = factory.new("boxCollider")
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