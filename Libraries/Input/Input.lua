return {
  new = function()
    local Input = {
          keyboard = nil,
          gamepad  = nil,
          mouse    = nil,
          current  = nil,
      }
      
    function Input:Load()  
      self.keyboard = require('Libraries/Input/Keyboard').new()
      self.gamepad  = require('Libraries/Input/Gamepad')
    end

    function Input:Update(dt)
      self.keyboard:Update(dt)
    end

    Input:Load()

    return Input
  end
}