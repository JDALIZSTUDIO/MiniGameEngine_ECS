local CController = require('Libraries/ECS/Components/c_Character_Controller')

return {
  new = function(_pECS)
    local component = CController.new(_pECS)
    
    local maxSpeed = 100
    local radius   = Resolution.screen.width*0.125
    local state    = nil
    local steering = nil
    local target   = nil
    
    local fnt = love.graphics.newFont()
    
    -----------------
    -- Custom_Load --
    -----------------
    function component:Custom_Load()
      state    = require('Libraries/StateMachine').new({"START", "GAMEPLAY", "END", "REPOSITION", "RESTART"})
      state:Set("START")
      
      steering = self.gameObject:GetComponent("steering")
      steering.maxVelocity = 600
      steering.maxForce    = 600
      
    end
    
    function component:Process_Input(dt)
      
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
        if(target == nil) then
          local ball  = self.ECS:Find("ball")
          if(ball ~= nil) then target = ball:GetComponent("transform") end
        else          
          local tarVec    = Vector2:New(transform.position.x, target.position.y)
          local distance  = transform.position:Distance(target.position)
          
          if(distance <= radius) then
            if(target.velocity.x > 0) then
              steering:Arrive(tarVec)              
            else
              steering:Arrive(transform.origin)              
            end            
          else
            steering:Arrive(transform.origin)            
          end          
        end
        
      elseif(state:Compare("END")) then
        state:Set("REPOSITION")
        
      elseif(state:Compare("REPOSITION")) then
        local transform = self.gameObject:GetComponent("transform")
        local dist      = transform.position:Distance(transform.origin)
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