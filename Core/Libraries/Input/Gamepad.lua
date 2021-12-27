local gp = {
  e_axis      = {},
  e_button    = {},
  axis        = {},
  buttons     = {},
}

function gp:Get_Axis(_pName)
  return self.axis[_pName]
end

function gp:Get_Button(_pName)
  return self.buttons[_pName]
end

function gp:SetAxies(_pTable)
  for i = 1, #_pTable do
    self.e_axis[i] = _pTable[i]
  end  
end

function gp:SetButtons(_pTable)
  for i = 1, #_pTable do
    self.e_buttons[i] = _pTable[i]
  end
end

function gp:Update(dt)
  
end

return gp