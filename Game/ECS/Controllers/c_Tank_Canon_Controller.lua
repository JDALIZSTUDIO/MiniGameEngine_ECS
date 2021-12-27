local factory  = require('Core/Libraries/ECS/Components/Controllers/c_Parent_Controller')

return {
  new = function()
    local component = factory.new()
          component.isReady = true
          component.radius  = 32
      
    local bb         = "boundingBox"
    local tr         = "transform"

    local deg        = math.deg
    local rad        = math.rad
    local cos        = math.cos
    local sin        = math.sin

    local timers     = nil
    local tName      = "reload"
    local tDuration  = 0.2
    
    local projectiles

    ----------
    -- Load --
    ----------
    function component:Load()
        projectiles = require('Game/ECS/Factories/f_Projectiles').new()
        timers      = require('Core/Libraries/Timers').new()
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
        end
    end
    
    ------------
    -- Update --
    ------------
    function component:Update(dt)
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