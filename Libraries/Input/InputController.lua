local Input = {
      keyboard = nil,
      gamepad  = nil,
      mouse    = nil,
      current  = nil,
  }
  
function Input:Load()  
  self.keyboard = require('Libraries/Input/KeyboardInput').new()
  self.gamepad  = require('Libraries/Input/GamepadInput')
end

function Input:Update(dt)
  self.keyboard:Update(dt)
end

function Input:Draw()
  
end

return Input