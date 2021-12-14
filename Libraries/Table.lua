return {
  new = function()
    local Table = {}
    
    function Table:To1D(_pTable, _pW, _pH)
      local t = {}
      for yy = 1, _pH do
        for xx = 1, _pW do
          table.insert(t, _pTable[xx][yy])
        end
      end
      return t      
    end
    
    function Table:Clone2D(_pTable, _pW, _pH)
      local t = self:NewTable2D(_pW, _pH)
      for yy = 1, _pH do
        for xx = 1, _pW do
          t[xx][yy] = _pTable[xx][yy]
        end
      end
      return t
    end
    
    function Table:NewTable2D(_pW, _pH)
      local t = {}
      for i = 1, _pH do
        t[i] = {}
        for j = 1, _pW do
            t[i][j] = nil
        end
      end
      return t
    end
    
    return Table
  end
}