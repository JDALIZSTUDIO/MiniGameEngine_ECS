return {
  new = function()
    local Table = {}
    
    function Table:To1D(_pTable, _pW, _pH)
      local table = {}
      for yy = 1, _pH do
        for xx = 1, _pW do
          table.insert(table, _pTable[xx][yy])
        end
      end
      return table      
    end

    function Table:Clone1D_To_2D(_pTable, _pW, _pH)
      local clone = self:New_Table_2D(_pW, _pH)
      local x, y
      for i = 1, #_pTable do
        x = math.floor((i - 1) % _pW) + 1
        y = math.floor((i - 1) / _pW) + 1
        clone[x][y] = _pTable[i]
      end     
      return clone
    end
    
    function Table:Clone2D(_pTable, _pW, _pH)
      local table = self:New_Table_2D(_pW, _pH)
      for yy = 1, _pH do
        for xx = 1, _pW do
          table[xx][yy] = _pTable[xx][yy]
        end
      end
      return table
    end
    
    function Table:New_Table_2D(_pW, _pH)
      local table = {}
      for i = 1, _pW do
        table[i] = {}
        for j = 1, _pH do
          table[i][j] = 0
        end
      end
      return table
    end
    
    return Table
  end
}