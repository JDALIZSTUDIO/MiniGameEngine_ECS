return {
  new = function()
    local Camera   = {
          clamped  = false,
          follower = nil,
          offset   = Vector2.new(),
          position = Vector2.new(),
          rotation = 0,
          shaker   = nil,
          scale    = Vector2.new(1, 1),
          target   = nil,
    }

    local clamp = Clamp
    local floor = math.floor

    ------------
    -- Attach --
    ------------
    function Camera:Attach(_pObj)
      self.target = _pObj
    end
    
    ------------
    -- Detach --
    ------------
    function Camera:Detach()
      self.target = nil
    end    

    ---------------------
    -- Screen_To_World --
    ---------------------
    function Camera:Screen_To_World(_pX, _pY)    
      return _pX / Aspect.scale + self.position.x - self.offset.x, 
             _pY / Aspect.scale + self.position.y - self.offset.y
    end  

    ----------
    -- Load --
    ----------
    function Camera:Load()
      self.follower = require('Libraries/Camera/Camera_Follower').new(self)
      self.shaker   = require('Libraries/Camera/Camera_Shaker').new()      
    end    

    -------------
    -- Look_At --
    -------------
    function Camera:Look_At(_pX, _pY)
      self.position.x = floor(_pX) or 0
      self.position.y = floor(_pY) or 0
    end

    ---------
    -- Set --
    ---------
    function Camera:Set()
      love.graphics.push()
        love.graphics.rotate (-self.rotation)
        love.graphics.scale (self.scale.x, self.scale.y)
        love.graphics.translate(-floor(self.position.x  - self.offset.x + self.shaker.offset.x), 
                                -floor((self.position.y - self.offset.y + self.shaker.offset.y)))
    end

    --------------
    -- SetScale --
    --------------
    function Camera:Set_Scale(_sX, _sY)
      self.scale.x = floor(_sX) or 1
      self.scale.y = floor(_sY) or 1
    end

    -----------
    -- Shake --
    -----------
    function Camera:Shake(_pMagnitude, _pDuration)
      self.shaker:Shake(_pMagnitude, _pDuration)
    end

    -----------
    -- UnSet --
    -----------
    function Camera:UnSet()
      love.graphics.pop()
    end

    ------------
    -- Update --
    ------------
    function Camera:Update(dt)
      self.offset:Set(
        Aspect.screen.width  * 0.5,
        Aspect.screen.height * 0.5
      )
      
      self.shaker:Update(dt)

      if(self.target ~= nil) then
        self.follower:Follow_Target(self.target)
        self.position.x = self.follower.position.x
        self.position.y = self.follower.position.y  
      else
        self.follower:Set_Position(self.position)
      end

      if(self.clamped) then
        local sw = self.offset.x * 2
        local sh = self.offset.y * 2
        self.position.x = clamp(self.position.x, self.offset.x, sw - self.offset.x)
        self.position.y = clamp(self.position.y, self.offset.y, sh - self.offset.y)
      end
    end
    
    ----------
    -- Draw --
    ----------
    function Camera:Draw()
      
    end
    
    return Camera
  end
}