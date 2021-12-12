return {
  new = function()
    local kb = {
      e_axis      = {},
      e_button    = {},
      axis        = {},
      buttons     = {},
      nbAxis      = 0,
      nbButtons   = 0
    }

    function kb:GetAxis(_pName)
      return self.axis[_pName]
    end

    function kb:GetButton(_pName)
      return self.buttons[_pName]
    end

    function kb:SetAxies(_pTable)
      for key, value in pairs(_pTable) do
        self.e_axis[key] = value
        self.nbAxis      = self.nbAxis + 1
        if(debug) then print("Keyboard, Added Axis: "..key..", "..value) end
      end
      if(debug) then print("Keyboard, Total Axies: "..self.nbAxis) end
    end

    function kb:SetButtons(_pTable)
      for key, value in pairs(_pTable) do
        self.e_button[key] = value
        self.nbButtons     = self.nbButtons + 1
        if(debug) then print("Keyboard, Added Button: "..key..", "..value) end
      end
      if(debug) then print("Keyboard, Total Buttons: "..self.nbButtons) end
    end
      
    function kb:Update(dt) 
      if(self.nbAxis > 0) then
        for key, value in pairs(self.e_axis) do
          self.axis[key] = love.keyboard.isDown(value)
        end
      end
      
      if(self.nbButtons > 0) then
        for key, value in pairs(self.e_button) do
          self.buttons[key] = love.keyboard.isDown(value)
        end
      end
      
    end

    return kb
  end
}