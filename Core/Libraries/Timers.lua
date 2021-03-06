return {
  new = function()
    local Class = {}
    
    local lstTimers = {}

    ---------
    -- Add --
    ---------
    function Class:Add_Timer(_pID, _pDuration)
      local timer     = self:_Return_New_Timer(_pDuration)
      lstTimers[_pID] = timer
      return timer
    end
    
    --------------
    -- Finished --
    --------------
    function Class:Is_Finished(_pID)
      local timer = lstTimers[_pID]
      if(timer ~= nil) then return timer.finished end
      return false
    end

    -----------------------
    -- _Return_New_Timer --
    -----------------------
    function Class:_Return_New_Timer(_pDuration)
      local timer = {
            duration = _pDuration or 1,
            elapsed  = 0,
            finished = true,
      }
      
      ------------
      -- Update --
      ------------
      function timer:Update(dt)
        if(timer.finished == false) then
          timer.elapsed = timer.elapsed + dt
          if(timer.elapsed >= timer.duration) then
            timer.finished = true
          end
        end
      end
      
      -----------
      -- Start --
      -----------
      function timer:Start()
        if(timer.finished == true) then          
          timer.elapsed  = 0
          timer.finished = false
        end
      end 
      
      return timer
    end
    
    -----------
    -- Start --
    -----------
    function Class:Start(_pID)
      lstTimers[_pID]:Start()
    end

    ------------
    -- Update --
    ------------
    function Class:Update(dt)
      for key, value in pairs(lstTimers) do
        value:Update(dt)
      end
    end

    return Class
  end
}