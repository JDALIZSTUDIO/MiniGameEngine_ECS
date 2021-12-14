return {
  new = function()
    local Controller = {
      fade   = {},
    }

    local debug = false

    function Controller:New()
      local f          = {  
            finished   = false,
            func       = nil,
            width      = love.graphics.getWidth(),
            height     = love.graphics.getHeight(),
            state      = "activate",
            state_pre  = "none",
            state_next = "none",
            alpha      = 1,
            speed_in   = 2,
            speed_out  = 3,
      }
      
      --------------
      -- Activate --
      --------------
      function f:Activate(_pFunc)    
        if(_pFunc ~= nil) then _pFunc() end
      end
      
      ----------
      -- Lerp --
      ----------
      function f:Lerp(initial_value, target_value, speed)
        local result = (1-speed) * initial_value + speed*target_value
        return result
      end
      
      -----------
      -- Start --
      -----------
      function f:Start(_pFunc)
        self.func       = _pFunc
        self.isFinished = false
        self.state      = "out"
      end
      
      ------------
      -- Update --
      ------------
      function f:Update(dt)    
        if self.state == "activate" then
          self:Activate(f.func)
          self.state = "in"
        end
        
        if self.state == "in" then
          self.alpha = self:Lerp(self.alpha, 0, self.speed_in * dt)
          if self.alpha < 0.01 then
            f.func     = nil
            self.alpha = 0
            self.state = "none"
          end
        end
        
        if self.state == "out" then
          self.alpha = self:Lerp(self.alpha, 1, self.speed_out * dt)
          if self.alpha > 0.99 then
            self.alpha = 1
            self.state = "activate"        
          end
        end
        
        if self.state == "none" then      
          
        end
      end

      function f:Draw()
        love.graphics.setColor(0, 0, 0, f.alpha)
          love.graphics.rectangle("fill", 0, 0, f.width, f.height)
        love.graphics.setColor(1, 1, 1, 1)
      end

      return f
    end

    -----------
    -- Start --
    -----------
    function Controller:Start(_pFunc)
      Controller.fade:Start(_pFunc)
    end

    ----------
    -- Load --
    ----------
    function Controller:Load()
      Controller.fade = Controller:New()
    end

    ------------
    -- Update --
    ------------
    function Controller:Update(dt)
      Controller.fade:Update(dt)
    end

    ----------
    -- Draw --
    ----------
    function Controller:Draw()
      Controller.fade.Draw()  
    end

    Controller:Load()
    
    return Controller
  end
}