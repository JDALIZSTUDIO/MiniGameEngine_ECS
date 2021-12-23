function table.new(_pOriginal)
  local original_type = type(_pOriginal)
  local copy
  if(original_type == 'table') then
    copy = {}
    for original_key, original_value in next, _pOriginal, nil do
      copy[table.new(original_key)] = table.new(original_value)
    end
  else
    copy = _pOriginal
  end
  return copy
end

function table.contains(val)
    for index, value in ipairs(self) do
        if value == val then
            return true
        end
    end

    return false
end