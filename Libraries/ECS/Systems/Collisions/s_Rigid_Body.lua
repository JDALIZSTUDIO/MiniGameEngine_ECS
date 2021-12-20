return {
    new = function() 
      local system = p_System.new({"transform", "boundingBox", "rigidBody"})
            system.gravity = 0

      local rb = "rigidBody"
      local tr = "transform"
      
      function system:Load(_pEntity)
        local controller = _pEntity:GetComponent(rb)
              
        if(isDebug) then print("Systems, loaded:      s_Rigid_Body by ".._pEntity.name) end
      end
      
      function system:Update(dt, _pEntity)
        local rigidBody = _pEntity:GetComponent(rb)
        local transform = _pEntity:GetComponent(tr)
        
        rigidBody:_Apply_Gravity(self.gravity)

        local direction = rigidBody:_Get_Direction()
        local length    = rigidBody.velocity:Length()
        local dx        = rigidBody:_Length_Dir_X(length, direction)
        local dy        = rigidBody:_Length_Dir_Y(length, direction)

        rigidBody:_Clamp_Velocity()
        
        transform.position:Set(
            transform.position.x + (dx * dt),
            transform.position.y + (dy * dt)
        )

        rigidBody:_Apply_Friction()
      end
      
      function system:Draw(_pEntity)
        local controller = _pEntity:GetComponent(id)
              
      end
      
      return system 
    end
  }