return {
  new = function()
    local f_controller  = Locator:Get_Service("f_controller")
    local Controller    = f_controller.new()          
          
        local max       = math.max
        local sin       = math.sin
        local time      = 0
        local scale     = 0
        local scale_min = 2
        local magnitude = 1.2
        local renderer, transform

        function Controller:Load()
            renderer  = self.gameObject:Get_Component("spriteGUIRenderer")
            transform = self.gameObject:Get_Component("transform")
        end
        
        function Controller:Update(dt)
          time  = time + 0.05
          local angle = (sin(time)+1)
          renderer.alpha = max(0.5, angle)
          scale = scale_min + (angle * magnitude)
          transform.scale:Set(
              scale,
              scale
            )
          transform.position:Set(
               love.mouse.getPosition()
          )
        end
        
        function Controller:Draw()
        
        end

        function Controller:Draw_GUI()
            
        end
  
    return Controller
  end
}