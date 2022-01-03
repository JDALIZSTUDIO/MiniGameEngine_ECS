return {
  new = function()
    local f_controller = Locator:Get_Service("f_character")
    local component    = f_controller.new()
          component.isReady = true
          component.radius  = 32
      
    local bb         = "boundingBox"
    local tr         = "transform"

    local atan2      = math.atan2
    local deg        = math.deg
    local rad        = math.rad
    local cos        = math.cos
    local sin        = math.sin
    local smoothAngle = Smooth_Angle

    local camera     = nil 
    local rSpeed     = 6
    local timers     = nil
    local tName      = "reload"
    local tDuration  = 0.2
    
    local projectiles
  
    ---------
    -- Aim --
    ---------
    function component:Aim_At(_pX, _pY, _pSpeed, dt)  
        local transform = self.gameObject:Get_Component(tr)
        local dx =   _pX - transform.position.x
        local dy = -(_pY - transform.position.y)
        transform.rotation = deg(smoothAngle(
          rad(transform.rotation),
          atan2(dx, dy),
          _pSpeed,
          dt
        ))
    end

    ----------
    -- Load --
    ----------
    function component:Load()
        camera      = Locator:Get_Service("camera")
        projectiles = require('Game/ECS/Factories/f_Projectiles').new()
        timers      = Locator:Get_Service("timers").new()
        timers:Add_Timer(tName, tDuration)
        timers:Start(tName)
    end

    -----------
    -- Shoot --
    -----------
    function component:Shoot()
        if(self.isReady) then
            local bBox      = self.gameObject:Get_Component(bb)
            local transform = self.gameObject:Get_Component(tr)
            local dir       = rad(transform.rotation-90)
            local x         = transform.parent.position.x + (cos(dir) * self.radius)
            local y         = transform.parent.position.y + (sin(dir) * self.radius)            
            local bullet    = self.gameObject.ECS:Create()

            projectiles:Init_Tank_Bullet(
                bullet,
                transform.parent.gameObject.name,
                x,
                y,
                dir
            )

            self.isReady = false
            timers:Start(tName)
            return true
        end
        return false
    end
    
    ---------------
    -- On_Update --
    ---------------
    function component:On_Update(dt)
        
        local mx, my = camera:Screen_To_World(love.mouse.getPosition())
        self:Aim_At(mx, my, rSpeed, dt)    

        if(love.mouse.isDown(1)) then
            self:Shoot()
        end

        if(self.isReady == false) then
            if(timers:Is_Finished(tName)) then
                self.isReady = true
            end
        end
        timers:Update(dt)
    end
    
    return component
  end
}