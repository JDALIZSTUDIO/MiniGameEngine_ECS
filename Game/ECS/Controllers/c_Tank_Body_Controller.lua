local factory  = require('Core/Libraries/ECS/Components/Controllers/c_Character_Controller')

return {
  new = function(_pECS)
    local component = factory.new(_pECS)
          
    local moving       = false
    local turret       = nil
    local gameObject   = nil
    local acceleration = 8
    local rSpeed       = 6

    local ch = "characterController"
    local an = "animator"
    local rb = "rigidBody"
    local tr = "transform"

    local deg         = math.deg
    local rad         = math.rad
    local atan2       = math.atan2
    local smoothAngle = Smooth_Angle

    -------------
    -- Animate --
    -------------
    function component:Animate() 
      local animator  = gameObject:Get_Component(an) 
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
      gameObject = component.gameObject
      
    end
    
    -------------------
    -- Process_Input --
    -------------------
    function component:Process_Input(dt)
      local rigidbody = gameObject:Get_Component(rb)

      moving = false
      if(Input.keyboard:GetAxis("up"))    then rigidbody:Add_Force({x = 0, y = -acceleration}) moving = true end
      if(Input.keyboard:GetAxis("down"))  then rigidbody:Add_Force({x = 0, y = acceleration})  moving = true end
      if(Input.keyboard:GetAxis("left"))  then rigidbody:Add_Force({x = -acceleration, y = 0}) moving = true end
      if(Input.keyboard:GetAxis("right")) then rigidbody:Add_Force({x =  acceleration, y = 0}) moving = true end

      local transform = gameObject:Get_Component(tr)

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