return {
  new = function()
    local f_controller  = Locator:Get_Service("f_controller")
    local Controller    = f_controller.new()
          local state   = Locator:Get_Service("state_machine").new({"NONE"})
          local timers  = Locator:Get_Service("timers")
          local timer   = nil                
          local target  = nil
          local counter = 3
          
          function Controller:Load()
            timer = timers:Add_Timer("start", 30)
          end
          
          function Controller:SetTarget(_pTransform)
            target = _pTransform.position
            
          end
          
          function Controller:Update(dt)
            timers.Update(dt)
          end
          
          function Controller:Draw()
            love.graphics.print()
          end
  
    return Controller
  end
}