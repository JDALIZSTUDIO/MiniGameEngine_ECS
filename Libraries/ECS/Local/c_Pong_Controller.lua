local CController = require('Libraries/ECS/Components/c_Player_Controller')

return {
  new = function(_pECS)
    local component = CController.new(_pECS)
    
    local inputDir  = Vector2.new(8)
    local state     = nil
    local maxSpeed  = 180
    local steering  = nil
    
    -----------------
    -- Custom_Load --
    -----------------
    function component:Custom_Load()
      state = require('Libraries/State_Machine').new({"START", "GAMEPLAY", "END", "REPOSITION", "RESTART"})
      state:Set("START")
      
      steering = self.gameObject:GetComponent("steering")
      steering.active = false      
      
    end
    
    -------------------
    -- Process_Input --
    -------------------
    function component:Process_Input(dt)
      inputDir:Set(0, 0)
      
      if(Input.keyboard:GetAxis("up") == true) then
        inputDir.y = -1
        
      elseif(Input.keyboard:GetAxis("down") == true) then
        inputDir.y = 1
        
      end
      
    end
    
    -----------
    -- Start --
    -----------
    function component:Start()
      state:Set("GAMEPLAY")
      
    end
    
    ----------
    -- Stop --
    ----------
    function component:Stop()
      state:Set("END")
      
    end
    
    ------------------
    -- Update_Logic --
    ------------------
    function component:Update_Logic(dt)      
      local transform = self.gameObject:GetComponent("transform")
      
      if(state:Compare("GAMEPLAY")) then
        transform.velocity.y = inputDir.y * maxSpeed
        
      elseif(state:Compare("END")) then
        steering.active = true
        state:Set("REPOSITION")
        
      elseif(state:Compare("REPOSITION")) then
        local dist = transform.position:Distance(transform.origin)
        
        if(dist > 0.2) then
          steering:Arrive(transform.origin)
          
        else
          steering.active = false
          state:Set("START")
          
        end        
      end
    end
      
    return component
  end
}