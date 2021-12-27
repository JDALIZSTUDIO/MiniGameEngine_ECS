local factory   = require('Core/Libraries/ECS/Components/Controllers/c_Character_Controller')
local particles = require('Game/Particles/Particles_Factory') 

return {
  new = function()
    local component = factory.new()
          
    local moving       = false
    local cannon       = nil
    local acceleration = 8
    local rSpeed       = 6

    local ps = "lParticleSystem"
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

      local child = transform:Get_Child(1)      
      if(child ~= nil) then
        local mx, my = Camera:Screen_To_World(love.mouse.getPosition())
        local dx =   mx - transform.position.x
        local dy = -(my - transform.position.y)
        child.transform.rotation = deg(smoothAngle(
          rad(child.transform.rotation),
          atan2(dx, dy),
          rSpeed,
          dt
        ))
      end

      local canon = child.transform.gameObject:Get_Component(ch)
      if(love.mouse.isDown(1)) then
        canon:Shoot()
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
              partSystem:Emit(particles:Smoke_Properties(position), rnd(3, 5))

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