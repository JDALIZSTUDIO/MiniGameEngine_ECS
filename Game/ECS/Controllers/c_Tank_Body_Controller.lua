local particles = require('Game/Particles/Particles_Factory') 

return {
  new = function()
    local f_character = Locator:Get_Service("f_character")
    local component   = f_character.new()
    
    local moving       = false
    local cannon       = nil
    local acceleration = 8
    local offsetCannon = {}

    local ps = "particleSystem"
    local ch = "characterController"
    local an = "animator"
    local rb = "rigidBody"
    local tr = "transform"

    local deg         = math.deg
    local cos         = math.cos
    local sin         = math.sin
    local rad         = math.rad
    local atan2       = math.atan2
    local pi          = math.pi
    local rnd         = math.random
    local smoothAngle = Smooth_Angle

    local rSpeed        = 6
    local timers        = nil
    local smokeStr      = "smoke"
    local smokeDuration = 0.15

    -------------
    -- Animate --
    -------------
    function component:Animate()
      local animator  = self.gameObject:Get_Component(an)
      if(moving) then
        animator:Play("move")
      else
        animator:Play("idle")
      end
    end

    -----------------
    -- Custom_Load --
    -----------------
    function component:Custom_Load()
      timers = require('Core/Libraries/Timers').new()
      timers:Add_Timer(smokeStr, smokeDuration)

      local rigid = self.gameObject:Get_Component(rb)
      normalSpeed = rigid:Get_MaxForce()
      turboSpeed  = normalSpeed * 2
 
      local partSystem = self.gameObject:Get_Component(ps)
      local emitter    = partSystem:Create(smokeStr)
            emitter:Set_Parameters(
              {
                
              }
            )
    end
    
    -------------------
    -- Process_Input --
    -------------------
    function component:Process_Input(dt)
      local rigidbody = self.gameObject:Get_Component(rb)

      local force = acceleration
      if(Input.keyboard:Get_Button("button3")) then
        force = acceleration * 1.5
      end

      moving = false
      if(Input.keyboard:Get_Axis("up"))    then rigidbody:Add_Force({x = 0, y = -force}) moving = true end
      if(Input.keyboard:Get_Axis("down"))  then rigidbody:Add_Force({x = 0, y = force})  moving = true end
      if(Input.keyboard:Get_Axis("left"))  then rigidbody:Add_Force({x = -force, y = 0}) moving = true end
      if(Input.keyboard:Get_Axis("right")) then rigidbody:Add_Force({x =  force, y = 0}) moving = true end

      local transform = self.gameObject:Get_Component(tr)

      if(rigidbody._Get_Magnitude() ~= 0) then
        local direction = rigidbody:_Get_Direction()
        transform.rotation = deg(smoothAngle(
          rad(transform.rotation),
          direction - (math.pi/2),
          rSpeed,
          dt
        ))
      end
    end

    ------------------
    -- Update_Logic --
    ------------------
    function component:Update_Logic(dt)
      if(moving and timers:Is_Finished(smokeStr)) then
        local rigid      = self.gameObject:Get_Component(rb)
        local transform  = self.gameObject:Get_Component(tr)

        local distance  = 16
        local direction = rigid:_Get_Direction()
        local position  = {
          x = transform.position.x + cos(direction) * distance,
          y = transform.position.y + sin(direction) * distance
        }

        local partSystem = self.gameObject:Get_Component(ps)
        local emitter    = partSystem:Get_Emitter(smokeStr)
              emitter:Set_Parameters()
              --partSystem:Emit(particles:Smoke_Properties(position), rnd(3, 5))

        timers:Start(smokeStr)
      end
      timers:Update(dt)
    end
    
    -----------------------
    -- On_Entity_Collision --
    -----------------------
    function component:On_Entity_Collision(_pTable)
      
    end
    
    ---------------------
    -- On_Tile_Collision --
    ---------------------
    function component:On_Tile_Collision(_pTileID)
      
    end    
    
    return component
  end
}