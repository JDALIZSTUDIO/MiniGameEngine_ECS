return {
  new = function()
    local Steering = p_Component.new("steering")
      Steering.angle          = 0
      Steering.friction       = 0.1
      Steering.lookAhead      = 64
      Steering.mass           = 100
      Steering.massMod        = 1
      Steering.maxAlign       = 2
      Steering.maxAvoidance   = 8
      Steering.maxCohesion    = 6
      Steering.maxForce       = 600
      Steering.maxSeparation  = 6
      Steering.maxVelocity    = 600
      Steering.radiusArrive   = 128
      Steering.radiusFlocking = 48
      Steering.steeringForce  = Vector2:New(0, 0)
      Steering.velocity       = Vector2:New(0, 0)
      Steering.rotationLocked = false
      Steering.zero           = Vector2:New(0, 0)
      
      -- Private Functions
      function Steering:Private_Arrive(_pOrigin, _pTarget)
        local force = Vector2:Subtract(_pTarget, _pOrigin)
        
        
        local dist = force:Length()
        force:Normalize()
        
        if(dist < self.radiusArrive) then
          force:MultiplyN(self.maxVelocity * dist / self.radiusArrive)
        else
          force:MultiplyN(self.maxVelocity)
        end
        
        force:Subtract(self.velocity)
        
        return force
      end
      
      function Steering:Private_Flee(_pOrigin, _pTarget)
        local force = self:Private_Seek(_pOrigin, _pTarget)
        force:MultiplyN(-1)
        return force
      end
      
      function Steering:Private_Seek(_pOrigin, _pTarget)
        local force = Vector2:Subtract(_pTarget, _pOrigin)
        force:Normalize()
        force:MultiplyN(self.maxVelocity)
        force:Subtract(self.velocity)
        
        return force
      end
      
      -- Public Functions
      function Steering:Arrive(_pOrigin, _pTarget)
        self.steeringForce:Add(self:Private_Arrive(_pOrigin, _pTarget))
      end

      function Steering:Flee(_pOrigin, _pTarget)
        self.steeringForce:Add(self:Private_Flee(_pOrigin, _pTarget))
      end

      function Steering:Seek(_pOrigin, _pTarget)
        self.steeringForce:Add(self:Private_Seek(_pOrigin, _pTarget))
      end
      
    return Steering    
  end
}