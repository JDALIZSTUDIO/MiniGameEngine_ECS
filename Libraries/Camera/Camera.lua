return {
  new = function()
    local Camera   = {
          position = Vector2.new(0, 0),
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
      if(Camera.target ~= nil) then
        Camera.position.x = Lerp(Camera.position.x, Camera.target.position.x, Camera.speed)
        Camera.position.y = Lerp(Camera.position.y, Camera.target.position.y, Camera.speed)
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