return {
  new = function()
    local Camera   = {
          ahead    = Vector2.new(),
          clamped  = true,
          isLook   = true,
          maxDist  = 48,
          position = Vector2.new(),
          rotation = 0,
          scale    = Vector2.new(1, 1),
          speed    = 0.2,
          target   = nil,
          timer    = 0,
    }

    ---------
    -- Set --
    ---------
    function Camera:Set()
      love.graphics.push()
        love.graphics.rotate (-Camera.rotation)
        love.graphics.scale (Camera.scale.x, Camera.scale.y)
        love.graphics.translate(-Camera.position.x, 
                                -Camera.position.y)
    end

    -----------
    -- UnSet --
    -----------
    function Camera:UnSet()
      love.graphics.pop()
    end

    -----------------
    -- SetPosition --
    -----------------
    function Camera:SetPosition(_pX, _pY)
      Camera.position.x = math.floor(_pX) or 0
      Camera.position.y = math.floor(_pY) or 0
    end

    --------------
    -- SetScale --
    --------------
    function Camera:SetScale(_sX, _sY)
      Camera.scale.x = math.floor(_sX) or 1
      Camera.scale.y = math.floor(_sY) or 1
    end

    ------------
    -- Attach --
    ------------
    function Camera:Attach(_pObj)
      Camera.target = _pObj
    end

    ------------
    -- Detach --
    ------------
    function Camera:Detach()
      Camera.target = nil
    end
    
    ------------
    -- Update --
    ------------
    function Camera:Update(dt)      
      local offsetX   = Round(Aspect.screen.width*0.5)
      local offsetY   = Round(Aspect.screen.height*0.5)

      if(self.target ~= nil) then

        if(self.isLook) then
          local w = love.graphics.getWidth()
          local h = love.graphics.getHeight()
          local mx, my = Screen_To_World(love.mouse.getPosition())
          if(mx > 0 and mx < w and
             my > 0 and my < h) then
              local dir  = self.target.position:DirectionTo({x = mx, y = my})
              local dist = self.target.position:Distance({x = mx, y = my})
              self.ahead:Set(
                self.target.position.x + (math.cos(dir) * math.min(dist, self.maxDist)),
                self.target.position.y + (math.sin(dir) * math.min(dist, self.maxDist))
              )
              self.position.x = Round(Lerp(self.position.x, self.ahead.x - offsetX, self.speed))
              self.position.y = Round(Lerp(self.position.y, self.ahead.y - offsetY, self.speed))
          else
            self.position.x = Round(Lerp(self.position.x, self.target.position.x - offsetX, self.speed))
            self.position.y = Round(Lerp(self.position.y, self.target.position.y - offsetY, self.speed))            
          end
        else
          self.position.x = Round(Lerp(self.position.x, self.target.position.x - offsetX, self.speed))
          self.position.y = Round(Lerp(self.position.y, self.target.position.y - offsetY, self.speed))
        end
      end

      if(self.clamped) then
        self.position.x = Clamp(self.position.x, Round(Aspect.screen.width  * 0.5), Round(Aspect.screen.width  - (Aspect.screen.width*0.5)))  - offsetX
        self.position.y = Clamp(self.position.y, Round(Aspect.screen.height * 0.5), Round(Aspect.screen.height - (Aspect.screen.height*0.5))) - offsetY
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