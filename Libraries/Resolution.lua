return {
  new = function()
      Controller = {
      screen     = nil,
      window     = nil,
      scale      = 1,
      success    = nil,
      dX         = 0,
      dY         = 0
    } 
    
    function Controller:GetMousePos()
      local mx, my = mouse.getPosition()
      return mx / self.scale, my / self.scale
    end
    
    function Controller:SetResolution(_pWindowWidth, _pWindowHeight, _pFullscreen)
      local success = love.window.setMode(_pWindowWidth, _pWindowHeight, {fullscreen = _pFullscreen})      
      --self.dX = self.window.width  - (self.scale * self.screen.width)  / 2
      --self.dY = self.window.height - (self.scale * self.screen.height) / 2
    end
    
    function Controller:SetWindow(_pScreenWidth, _pScreenHeight, _pScale, _pFullscreen)      
      self.scale         = _pScale      
      self.screen        = {
        fullscreen       = _pFullscreen or false,
        width            = _pScreenWidth,
        height           = _pScreenHeight,
        ratio            = _pScreenWidth / _pScreenHeight,
        xt               = 0,
        yt               = 0
      }
      
      local windowWidth  = _pScreenWidth  * _pScale
      local windowHeight = _pScreenHeight * _pScale
    
      self.window = {
        width     = windowWidth,
        height    = windowHeight,
        ratio     = windowWidth / windowHeight
      }
      
      self:SetResolution(windowWidth, windowHeight, _pFullscreen)
    end
  
    function Controller:Set()
      love.graphics.push()
      love.graphics.translate(self.dX, self.dY)
      love.graphics.scale(self.scale, self.scale)
      
    end
    
    function Controller:UnSet()
      love.graphics.scale(1/self.scale, 1/self.scale)
      love.graphics.translate(-self.dX, -self.dY)
      love.graphics.pop()
      
    end
  
    return Controller
  end
}