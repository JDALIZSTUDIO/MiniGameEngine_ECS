return {
  new = function()
    local TC = {
      fade   = {},
    }

    local debug = false

    function TC:New()
      local f          = {  
            finished   = false,
            func       = nil,
            width      = love.graphics.getWidth(),
            height     = love.graphics.getHeight(),
            state      = "activate",
            state_pre  = "none",
            state_next = "none",
            alpha      = 1,
            speed_in   = 1.4,
            speed_out  = 2.4,
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
    function TC:Start(_pFunc)
      TC.fade:Start(_pFunc)
    end

    ----------
    -- Load --
    ----------
    function TC:Load()
      TC.fade = TC:New()
    end

    ------------
    -- Update --
    ------------
    function TC:Update(dt)
      TC.fade:Update(dt)
    end

    ----------
    -- Draw --
    ----------
    function TC:Draw()
      TC.fade.Draw()  
    end

    return TC
  end
}