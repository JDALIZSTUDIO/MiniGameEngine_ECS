return {
  new = function(_pTable)
    local State_Machine = {
      index             = nil,
      states            = {},
      state             = nil
    }
    
    function State_Machine:Parse(_pTable)
      local length  = #_pTable
      for i = 1, length do
        self.states[_pTable[i]] = i
      end
    end
    
    function State_Machine:Compare(_pState)
      return self.state == self.states[_pState]
    end
    
    function State_Machine:Get_Index()
      return self.state
    end

    function State_Machine:Get_Name()
      for key, value in pairs(self.states) do
        if(self:Get_Index() == value) then
          return key
        end
      end
      return null
    end
    
    function State_Machine:Set(_pState)
      self.state = self.states[_pState]
    end
    
    State_Machine:Parse(_pTable)
    State_Machine:Set(_pTable[1])

    return State_Machine
  end
}