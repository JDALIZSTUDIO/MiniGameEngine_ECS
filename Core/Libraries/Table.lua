return {
  new = function()
    local Table = {}
    
    local floor  = math.floor
    local insert = table.insert

    function Table:GetPairsCount(_pTable)
      local count = 0
      for key, value in pairs(_pTable) do
        if(value ~= nil) then count = count+1 end
      end
      return count
    end

    function Table:To1D(_pTable, _pW, _pH)
      local table = {}
      for yy = 1, _pH do
        for xx = 1, _pW do
          insert(table, _pTable[xx][yy])
        end
      end
      return table      
    end

    function Table:Clone1D_To_2D(_pTable, _pW, _pH)
      local clone = self:New_Table_2D(_pW, _pH)
      local x, y
      for i = 1, #_pTable do
        x = floor((i - 1) % _pW) + 1
        y = floor((i - 1) / _pW) + 1
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