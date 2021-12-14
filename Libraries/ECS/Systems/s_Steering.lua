return {
  new = function() 
    local system = p_System.new({"transform", "steering"})
  
      ----------
      -- Load --
      ----------
    function system:Load(_pEntity)
      local steering  = _pEntity:GetComponent("steering")
            steering:Load()
      
      if(debug) then print("Systems, loaded:      s_Steering by ".._pEntity.name) end
    end
    
      ------------
      -- Update --
      ------------
    function system:Update(dt, _pEntity)
      local steering = _pEntity:GetComponent("steering")
      if(steering.active == false) then return end      
            
      if(steering.friction ~= 0) then
        local frc  = (1 - steering.friction)
        local coef = frc + (frc*0.1)
        steering.velocity:MultiplyN(coef)
      end      
      
      steering.steeringForce = Vector2:ClampMagnitude(steering.steeringForce, steering.maxForce)      
      steering.velocity:Add(steering.steeringForce)
      steering.velocity = Vector2:ClampMagnitude(steering.velocity, steering.maxVelocity)
      
      if(steering.rotationLocked == false) then        
        if(steering.velocity.x ~= 0 and steering.velocity.y ~= 0) then
          local velocity = steering.velocity:Clone()
          local dir = velocity:Direction() + (math.pi/-2)        
          steering.angle = math.deg(dir)
          if(steering.angle < 0) then steering.angle = steering.angle + 360 end
          if(steering.angle > 360) then steering.angle = steering.angle - 360 end
          transform.rotation = steering.angle
        end
      end
      
      local transform = _pEntity:GetComponent("transform")      
      transform.velocity:Set(steering.velocity.x, steering.velocity.y) 
      
      steering.steeringForce:Set(0, 0)
      steering.velocity:Set(0, 0)      
    end
    
    return system 
  end
}