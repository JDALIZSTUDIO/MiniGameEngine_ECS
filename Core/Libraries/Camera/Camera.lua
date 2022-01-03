return {
  new = function(_pX, _pY)
    local aspect   = Locator:Get_Service("aspect")
    local Class    = {
          active   = false,
          clamped  = false,
          follower = nil,
          offset   = { x = 0, y = 0 },
          position = { 
            x = _pX or 0, 
            y = _pY or 0 
          },
          rotation = 0,
          shaker   = nil,
          scale    = { x = 1, y = 1 },
          target   = nil,
    }

    local clamp = Clamp
    local floor = math.floor
  
    ------------
    -- Attach --
    ------------
    function Class:Attach(_pObj)
      self.target = _pObj
    end

    ----------------
    -- Attach_Ext --
    ----------------
    function Class:Attach_Ext(_pObj, _pX, _pY)
      self.target = _pObj
      self.follower:Set_Position(
        _pX, 
        _pY
      )
    end
    
    ------------
    -- Detach --
    ------------
    function Class:Detach()
      self.target = nil
    end    

    ---------------------
    -- Screen_To_World --
    ---------------------
    function Class:Screen_To_World(_pX, _pY)    
      return _pX / aspect.scale + self.position.x - self.offset.x, 
             _pY / aspect.scale + self.position.y - self.offset.y
    end  

    ----------
    -- Load --
    ----------
    function Class:Load()
      self.follower = require('Core/Libraries/Camera/Camera_Follower').new(self)
      self.shaker   = require('Core/Libraries/Camera/Camera_Shaker').new()      
    end    

    -------------
    -- Look_At --
    -------------
    function Class:Look_At(_pX, _pY)
      self.position = {
        x = floor(_pX),
        y = floor(_pY)
      }
    end

    ---------
    -- Set --
    ---------
    function Class:Set()
      love.graphics.push()
        love.graphics.rotate (-self.rotation)
        love.graphics.scale (self.scale.x, self.scale.y)
        love.graphics.translate(-floor(self.position.x  - self.offset.x + self.shaker.offset.x), 
                                -floor((self.position.y - self.offset.y + self.shaker.offset.y)))
    end

    --------------
    -- SetScale --
    --------------
    function Class:Set_Scale(_sX, _sY)
      self.scale.x = floor(_sX) or 1
      self.scale.y = floor(_sY) or 1
    end

    -----------
    -- Shake --
    -----------
    function Class:Shake(_pMagnitude, _pDuration)
      self.shaker:Shake(_pMagnitude, _pDuration)
    end

    -----------
    -- UnSet --
    -----------
    function Class:UnSet()
      love.graphics.pop()
    end

    ------------
    -- Update --
    ------------
    function Class:Update(dt)
      self.offset = {
        x = aspect.screen.width  * 0.5,
        y = aspect.screen.height * 0.5
      }      

      self.shaker:Update(dt)

      if(self.active) then
        if(self.target ~= nil) then
          self.follower:Follow_Target(self.target)
          self.position.x = self.follower.position.x
          self.position.y = self.follower.position.y  
        else
          self.follower:Set_Position(self.position)
        end
      end

      if(self.clamped) then
        local sw = self.offset.x * 2
        local sh = self.offset.y * 2
        self.position.x = clamp(self.position.x, self.offset.x, sw - self.offset.x)
        self.position.y = clamp(self.position.y, self.offset.y, sh - self.offset.y)
      end
    end
    
    ---------------------
    -- World_To_Screen --
    ---------------------
    function Class:World_To_Screen(_pX, _pY)
      return (_pX - self.position.x + self.offset.x) * aspect.scale, 
             (_pY - self.position.y + self.offset.y) * aspect.scale
    end  

    ----------
    -- Draw --
    ----------
    function Class:Draw()
      
    end
    
    return Class
  end
}