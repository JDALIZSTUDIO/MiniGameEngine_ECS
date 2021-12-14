local Vector2 = {}

function Vector2:Add(_pVector2A, _pVector2B)
    return Vector2.new(_pVector2A.x + _pVector2B.x, _pVector2A.y + _pVector2B.y)
end

function Vector2:ClampMagnitude(_pVector2, _pScalar)
  local vec2   = _pVector2:Clone()
  
  local length = vec2:Length()
  
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
    local v = {
          x = _pX or 0,
          y = _pY or 0,
    }

    function v:Clone()
        return Vector2.new(v.x, v.y)
    end

    function v:Add(_pVector2)
        v.x = v.x + _pVector2.x
        v.y = v.y + _pVector2.y
    end

    function v:AddN(_pScalar)
        v.x = v.x + _pScalar
        v.y = v.y + _pScalar
    end

    function v:Subtract(_pVector2)
        v.x = v.x - _pVector2.x
        v.y = v.y - _pVector2.y
    end

    function v:SubtractN(_pScalar)
        v.x = v.x - _pScalar
        v.y = v.y - _pScalar
    end

    function v:Multiply(_pVector2)
        v.x = v.x * _pVector2.x
        v.y = v.y * _pVector2.y
    end

    function v:MultiplyN(_pScalar)
        v.x = v.x * _pScalar
        v.y = v.y * _pScalar
    end
    
    function v:Clamp(_pScalar)
      if(v.x > _pScalar) then v.x = _pScalar end
      if(v.y > _pScalar) then v.y = _pScalar end
      if(v.x < -_pScalar) then v.x = -_pScalar end
      if(v.y < -_pScalar) then v.y = -_pScalar end
    end
    
    function v:Direction()
        return math.atan2(0 - v.y, 0 - v.x)
    end

    function v:Divide(_pVector2)
        v.x = v.x / _pVector2.x
        v.y = v.y / _pVector2.y
    end

    function v:DivideN(_pScalar)
        v.x = v.x / _pScalar
        v.y = v.y / _pScalar
    end

    function v:Distance(_pVector2)
        return math.sqrt((_pVector2.x - v.x) ^ 2 + (_pVector2.y - v.y) ^ 2)
    end

    function v:Length()
        return math.sqrt(v.x * v.x + v.y * v.y)
    end

    function v:Normalize()
        local length = v:Length()
        v.x = v.x / length
        v.y = v.y / length
    end

    function v:Set(_pX, _pY)
        v.x = _pX
        v.y = _pY
    end

  return v
end

function Vector2:Zero()
    return self:New(0, 0)
end

return Vector2