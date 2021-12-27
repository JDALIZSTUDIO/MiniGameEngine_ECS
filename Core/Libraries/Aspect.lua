return {
  new = function()
      Aspect     = {
      screen     = nil,
      window     = nil,
      scale      = 1,
      success    = nil,
      fullScaleX = 0,
      fullScaleY = 0,
      dX         = 0,
      dY         = 0
    } 
    
    function Aspect:GetMousePos()
      local mx, my = mouse.getPosition()
      return mx / self.scale, my / self.scale
    end
    
    function Aspect:SetAspect(_pWindowWidth, _pWindowHeight, _pFullscreen)
      local success = love.window.setMode(_pWindowWidth, _pWindowHeight, {fullscreen = _pFullscreen})
      self.fullScaleX = love.graphics.getWidth()  / _pWindowWidth
      self.fullScaleY = love.graphics.getHeight() / _pWindowHeight
      self.dX = love.graphics.getWidth()  * (1-self.fullScaleX)
      self.dY = love.graphics.getHeight() * (1-self.fullScaleY)
    end
    
    function Aspect:SetWindow(_pScreenWidth, _pScreenHeight, _pScale, _pFullscreen)      
      self.scale         = _pScale      
      self.screen        = {
        fullscreen       = _pFullscreen or false,
        width            = _pScreenWidth,
        height           = _pScreenHeight,
        ratio            = _pScreenWidth / _pScreenHeight,
        dX               = 0,
        dY               = 0
      }
      
      local windowWidth  = _pScreenWidth  * _pScale
      local windowHeight = _pScreenHeight * _pScale
    
      self.window = {
        width     = windowWidth,
        height    = windowHeight,
        ratio     = windowWidth / windowHeight
      }
      
      self:SetAspect(windowWidth, windowHeight, _pFullscreen)
    end
  
    function Aspect:Set()
      love.graphics.push()
      love.graphics.translate(self.dX, self.dY)
      love.graphics.scale(self.scale, self.scale)
      
    end
    
    function Aspect:UnSet()
      love.graphics.scale(1/self.scale, 1/self.scale)
      love.graphics.translate(-self.dX, -self.dY)
      love.graphics.pop()      
    end
  
    return Aspect
  end
}