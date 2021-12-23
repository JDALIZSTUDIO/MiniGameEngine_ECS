local Steering       = {
      controller     = nil,
      owner          = nil,
}

function Steering:New(_pOwner)
  Steering.owner    = _pOwner
  
  local st             = {
        angle          = 0,
        friction       = 0.1,
        lookAhead      = 128,
        mass           = 5,
        massMod        = 1,
        maxAlign       = 2,
        maxAvoidance   = 8,
        maxCohesion    = 6,
        maxForce       = 10,
        maxSeparation  = 6,
        maxVelocity    = 6,
        velocity       = 6,
        radiusArrive   = 48,
        radiusFlocking = 48,
        steeringForce  = Vector2.new(),
        velocity       = Vector2.new(),
        rotationLocked = true,
        zero           = Vector2.new(),
  }
  
  -- Steering Functions
  function st:Arrive(_pVector2Target)
    local force = Vector2:Subtract(_pVector2Target, Steering.owner.position)
    force:Normalize()
    
    local dist = force:Magnitude()
    if(dist < st.radiusArrive) then
      force:MultiplyN(st.maxVelocity * dist / st.radiusArrive)
    else
      force:MultiplyN(st.maxVelocity)
    end
    
    force:Subtract(st.velocity)
    
    return force
  end
  
  function st:Flee(_pVector2Target)
    local force = st:Seek(_pVector2Target)
    force:MultiplyN(-1)
    return force
  end
  
  function st:Seek(_pVector2Target)
    local force = Vector2:Subtract(_pVector2Target, Steering.owner.position)
    force:Normalize()
    force:MultiplyN(st.maxVelocity)
    focre:Subtract(st.velocity)
    return force
  end
  
  -- Update
  function st:Update(dt)
    if(Steering.owner == nil) then return end
    
    if(st.friction ~= 0) then
      local frc  = (1 - st.friction)
      local coef = frc + (frc*0.1)
      st.velocity.MultiplyN(coef)
    end
    
    st.steeringForce = Vector2:ClampMagnitude(st.velocity, st.maxForce)
    
    st.velocity:Add(st.steeringForce)
    st.velocity = Vector2:ClampMagnitude(st.velocity, st.maxVelocity)
    
    if(st.rotationLocked == false) then
      local difference = Vector2:Subtract(st.zero, st.velocity)
      local angle      = math.atan2(difference.y, difference.x)
      local inDegrees  = math.deg(angle)
      st.angle         = inDegrees-90
    end
    
    local vel = Vector2:MultiplyN(st.velocity, dt)
    Steering.owner.position:Add(vel)
    
    st.steeringForce:Set(0, 0)
    st.velocity:Set(0, 0)
  end
  
  Steering.controller = st
end

-- Public Steering Functions
function Steering:Arrive(_pVector2Target)
  Steering.controller.steeringForce:Add(Steering.controller:Arrive(_pVector2Target))
end

function Steering:Flee(_pVector2Target)
  Steering.controller.steeringForce:Add(Steering.controller:Flee(_pVector2Target))
end

function Steering:Seek(_pVector2Target)
  Steering.controller.steeringForce:Add(Steering.controller:Seek(_pVector2Target))
end

-- Base Functions
function Steering:Update(dt)
  if(Steering.owner == nil) then return end
  if(Steering.controller == nil) then return end  
  Steering.controller.Update(dt)
end

return Steering