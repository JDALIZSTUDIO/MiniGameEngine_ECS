return {
    new = function()
        local factory = Locator:Get_Service("f_component")
        local component = factory.new("tileBlocker")
        
        return component  
    end
  }