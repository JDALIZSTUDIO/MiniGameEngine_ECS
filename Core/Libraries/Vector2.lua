local Vector2 = {}

local max = math.max

function Vector2:Add(_pVector2A, _pVector2B)
    return Vector2.new(_pVector2A.x + _pVector2B.x, _pVector2A.y + _pVector2B.y)
end

function Vector2:ClampMagnitude(_pVector2, _pScalar)
  local vec2   = _pVector2:Clone()
  
  local length = vec2:Magnitude()
  
  if(length > _pScalar) then
    vec2:Normalize()
    vec2:MultiplyN(_pScalar)
  end
  
  return vec2
end

function Vector2:Subtract(_pVector2A, _pVector2B)
    return Vector2.new(_pVector2A.x - _pVector2B.x, _pVector2A.y - _pVector2B.y)
end

function Vector2:Multiply(_pVector2A, _pVector2B)
    return Vector2.new(_pVector2A.x * _pVector2B.x, _pVector2A.y * _pVector2B.y)
end

function Vector2:MultiplyN(_pVector2A, _pScalar)
    return Vector2.new(_pVector2A.x * _pScalar, _pVector2A.y * _pScalar)
end

function Vector2:Divide(_pVector2A, _pVector2B)
    return Vector2.new(_pVector2A.x / _pVector2B.x, _pVector2A.y / _pVector2B.y)
end

Vector2.new = function(_pX, _pY)
    local vec2 = {
          x    = _pX or 0,
          y    = _pY or 0,
    }

    local atan2 = math.atan2
    local sqrt  = math.sqrt

    function vec2:Clone()
        return Vector2.new(self.x, self.y)
    end

    function vec2:Add(_pVector2)
        self.x = self.x + _pVector2.x
        self.y = self.y + _pVector2.y
    end

    function vec2:AddN(_pScalar)
        self.x = self.x + _pScalar
        self.y = self.y + _pScalar
    end

    function vec2:Subtract(_pVector2)
        self.x = self.x - _pVector2.x
        self.y = self.y - _pVector2.y
    end

    function vec2:SubtractN(_pScalar)
        self.x = self.x - _pScalar
        self.y = self.y - _pScalar
    end

    function vec2:Multiply(_pVector2)
        self.x = self.x * _pVector2.x
        self.y = self.y * _pVector2.y
    end

    function vec2:MultiplyN(_pScalar)
        self.x = self.x * _pScalar
        self.y = self.y * _pScalar
    end
    
    function vec2:Clamp(_pScalar)
      if(self.x > _pScalar)  then self.x = _pScalar end
      if(self.y > _pScalar)  then self.y = _pScalar end
      if(self.x < -_pScalar) then self.x = -_pScalar end
      if(self.y < -_pScalar) then self.y = -_pScalar end
    end
    
    function vec2:Direction()
        return atan2(0 - self.y, 0 - self.x)
    end

    function vec2:Direction_To(_pVector2)
        return atan2(_pVector2.y - self.y, _pVector2.x - self.x)
    end

    function vec2:Distance_To(_pVector2)
        return sqrt((_pVector2.x - self.x) ^ 2 + (_pVector2.y - self.y) ^ 2)
    end

    function vec2:Divide(_pVector2)
        self.x = self.x / _pVector2.x
        self.y = self.y / _pVector2.y
    end

    function vec2:DivideN(_pScalar)
        self.x = self.x / _pScalar
        self.y = self.y / _pScalar
    end

    function vec2:Magnitude()
        return sqrt(self.x * self.x + self.y * self.y)
    end

    function vec2:Normalize()
        local length = vec2:Magnitude()
        if(length <= 0) then
            self.x = 0
            self.y = 0
        else
            self.x = self.x / length
            self.y = self.y / length
        end
    end

    function vec2:Set(_pX, _pY)
        self.x = _pX
        self.y = _pY
    end

  return vec2
end

function Vector2:Zero()
    return self:New(0, 0)
end

return Vector2