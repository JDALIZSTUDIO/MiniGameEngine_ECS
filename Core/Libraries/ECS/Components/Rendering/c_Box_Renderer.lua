return {
  new = function()
    local f_component    = Locator:Get_Service("f_component")
    local renderer       = f_component.new("boxRenderer")
          renderer.debug = true
    
    
    return renderer  
  end
}