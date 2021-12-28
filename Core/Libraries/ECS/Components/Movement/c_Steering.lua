return {
  new = function()
    local f_component              = Locator:Get_Service("f_component")
    local component                = f_component.new("steering")
          component.angle          = 0
          component.friction       = 0.1
          component.lookAhead      = 64
          component.mass           = 100
          component.massMod        = 1
          component.maxAlign       = 2
          component.maxAvoidance   = 8
          component.maxCohesion    = 6
          component.maxForce       = 400
          component.maxSeparation  = 6
          component.maxVelocity    = 400
          component.radiusArrive   = 48
          component.radiusFlocking = 48
          component.steeringForce  = Vector2.new(0, 0)
          component.velocity       = Vector2.new(0, 0)
          component.rotationLocked = false
          component.zero           = Vector2.new(0, 0)
          component.precision      = 0.1
      
      local transform = nil
      
      ----------
      -- Load --
      ----------
      function component:Load()
        transform = self.gameObject:Get_Component("transform")
      end
      
      --------------------
      -- Private_Arrive --
      --------------------
      function component:Private_Arrive(_pTarget)
        if(transform.position:Distance_To(_pTarget) < self.precision) then return Vector2.new(0, 0) end        
        
        local force = Vector2:Subtract(_pTarget, transform.position)
        
        local dist = force:Magnitude()
        force:Normalize()
        
        if(dist < self.radiusArrive) then
          force:MultiplyN(self.maxVelocity * dist / self.radiusArrive)
        else
          force:MultiplyN(self.maxVelocity)
        end
        
        force:Subtract(self.velocity)
        
        return force
      end
      
      ------------------
      -- Private_Flee --
      ------------------
      function component:Private_Flee(_pTarget)
        local force = self:Private_Seek(transform.position,  _pTarget)
        force:MultiplyN(-1)
        return force
      end
      
      ------------------
      -- Private_Seek --
      ------------------
      function component:Private_Seek(_pTarget)        
        if(transform.position:Distance_To(_pTarget) < self.precision) then return Vector2.new(0, 0) end
        
        local force = Vector2:Subtract(_pTarget, transform.position)
        force:Normalize()
        force:MultiplyN(self.maxVelocity)
        force:Subtract(self.velocity)
        
        return force
      end
      
      ------------
      -- Arrive --
      ------------
      function component:Arrive(_pTarget)
        if(_pTarget == nil) then return end
        self.steeringForce:Add(self:Private_Arrive(_pTarget))
      end

      ----------
      -- Flee --
      ----------
      function component:Flee(_pTarget)
        if(_pTarget == nil) then return end
        self.steeringForce:Add(self:Private_Flee(_pTarget))
      end

      ----------
      -- Seek --
      ----------
      function component:Seek(_pTarget)
        if(_pTarget == nil) then return end
        self.steeringForce:Add(self:Private_Seek(_pTarget))
      end
      
    return component    
  end
}