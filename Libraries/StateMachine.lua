return {
  new = function(_pTable)
    local StateMachine = {
      states = {},
      state  = nil
    }
    
    function StateMachine:Parse(_pTable)
      local length  = #_pTable
      for i = 1, length do
        self.states[_pTable[i]] = i
      end
    end
    
    function StateMachine:Compare(_pState)
      return self.state == self.states[_pState]
    end
    
    function StateMachine:Get()
      return self.state
    end
    
    function StateMachine:Set(_pState)
      self.state = self.states[_pState]
    end
    
    StateMachine:Parse(_pTable)
    StateMachine:Set(_pTable[1])

    return StateMachine
  end
}