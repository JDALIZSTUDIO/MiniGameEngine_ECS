return {
  new = function(_pParameters)
    local p = _pParameters or {}

    local component = p_Component.new("rigidBody")
          component.velocity = Vector2.new()
          component.friction = p.friction or 0.95
          component.isStatic = p.isStatic or false
          component.maxForce = p.maxForce or 60
    
    local deg = math.deg
    local cos = math.cos
    local sin = math.sin
    local max = math.max
    local min = math.min

    ---------------
    -- Add_Force --
    ---------------
    function component:Add_Force(_pForce)
      self.velocity:Set(
        self.velocity.x - _pForce.x,
        self.velocity.y - _pForce.y
      )
    end

    ---------------------
    -- _Apply_Friction --
    ---------------------
    function component:_Apply_Friction()
      self.velocity:MultiplyN(self.friction)
    end

    --------------------
    -- _Apply_Gravity --
    --------------------
    function component:_Apply_Gravity(_pGravity)
      self.velocity.y = self.velocity.y + _pGravity
    end

    ---------------------
    -- _Clamp_Velocity --
    ---------------------
    function component:_Clamp_Velocity()
      if(self.velocity.x > 0) then
        self.velocity.x = min(self.velocity.x, self.maxForce)
      elseif(self.velocity.x < 0) then
        self.velocity.x = max(self.velocity.x, -self.maxForce)
      end
      if(self.velocity.y > 0) then
        self.velocity.y = min(self.velocity.y, self.maxForce)
      elseif(self.velocity.y < 0) then
        self.velocity.y = max(self.velocity.y, -self.maxForce)
      end
    end

    --------------------
    -- _Get_Direction --
    --------------------
    function component:_Get_Direction()
      return self.velocity:Direction()
    end

    -------------------
    -- _Length_Dir_X --
    -------------------
    function component:_Length_Dir_X(_pSpeed, _pDirection)
      return cos(_pDirection) * _pSpeed
    end

    -------------------
    -- _Length_Dir_Y --
    -------------------
    function component:_Length_Dir_Y(_pSpeed, _pDirection)
      return sin(_pDirection) * _pSpeed
    end
    
    ------------------
    -- Set_Velocity --
    ------------------
    function component:Set_Velocity(_pVX, _pVY)
      self.velocity:Set(
        _pVX,
        _pVY
      )
    end
    
    return component  
  end
}