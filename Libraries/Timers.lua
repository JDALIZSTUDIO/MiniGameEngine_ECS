return {
  new = function()
    local Timers = {
      lstTimers = {}
    }
    
    function Timers:Add(_pID, _pDuration)
      local timer = self:New(_pDuration)
      self.lstTimers[_pID] = timer
      return timer
    end
    
    function Timers:Finished(_pID)
      return self.lstTimers[_pID].finished
    end

    function Timers:New(_pDuration)
      local timer = {
            duration = _pDuration or 1,
            elapsed  = 0,
            finished = true,
      }
      
      function timer:Update(dt)
        if(timer.finished == false) then
          timer.elapsed = timer.elapsed + dt
          if(timer.elapsed >= timer.duration) then
            timer.finished = true
          end
        end
      end
      
      function timer:Start()
        if(timer.finished == true) then          
          timer.elapsed  = 0
          timer.finished = false
        end
      end 
      
      return timer
    end
    
    function Timers:Start(_pID)
      self.lstTimers[_pID]:Start()
    end

    function Timers:Update(dt)
      for key, value in pairs(self.lstTimers) do
        value:Update(dt)
      end
    end

    return Timers
  end
}