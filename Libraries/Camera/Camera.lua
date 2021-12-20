return {
  new = function()
    local Camera   = {
          clamped  = false,
          follower = nil,
          position = Vector2.new(),
          rotation = 0,
          shaker   = nil,
          scale    = Vector2.new(1, 1),
          target   = nil
    }

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

    ----------
    -- Load --
    ----------
    function Camera:Load()
      self.follower = require('Libraries/Camera/Camera_Follower').new()
      self.shaker   = require('Libraries/Camera/Camera_Shaker').new()
    end
    
    ---------
    -- Set --
    ---------
    function Camera:Set()
      local offsetX = Aspect.screen.width  * 0.5
      local offsetY = Aspect.screen.height * 0.5
      love.graphics.push()
        love.graphics.rotate (-self.rotation)
        love.graphics.scale (self.scale.x, self.scale.y)
        love.graphics.translate(-math.floor(self.position.x  - offsetX + self.shaker.offset.x), 
                                -math.floor((self.position.y - offsetY + self.shaker.offset.y)))
    end

    -----------------
    -- SetPosition --
    -----------------
    function Camera:Set_Position(_pX, _pY)
      self.position.x = math.floor(_pX) or 0
      self.position.y = math.floor(_pY) or 0
    end

    --------------
    -- SetScale --
    --------------
    function Camera:Set_Scale(_sX, _sY)
      self.scale.x = math.floor(_sX) or 1
      self.scale.y = math.floor(_sY) or 1
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
      self.shaker:Update(dt)

      if(self.target ~= nil) then
        self.follower:Follow_Target(self.target)
        self.position.x = self.follower.position.x
        self.position.y = self.follower.position.y  
      else
        self.follower:Set_Position(self.position)
      end

      if(self.clamped) then
        self.position.x = Clamp(self.position.x, Aspect.screen.width  * 0.5, Aspect.screen.width  - (Aspect.screen.width*0.5))
        self.position.y = Clamp(self.position.y, Aspect.screen.height * 0.5, Aspect.screen.height - (Aspect.screen.height*0.5))
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