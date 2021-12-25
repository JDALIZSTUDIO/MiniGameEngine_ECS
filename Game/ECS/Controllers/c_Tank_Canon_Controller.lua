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
    
    ----------
    -- Load --
    ----------
    function component:Load()
        timers = require('Core/Libraries/Timers').new()
        timers:Add(tName, tDuration)
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
                  bullet:Add_Component(require('Game/ECS/Controllers/c_Bullet_Controller').new({owner = transform.parent.gameObject.name}))
                  bullet:Add_Component(require('Core/Libraries/ECS/Components/Movement/c_Transform').new(x, y, deg(dir)))
                  bullet:Add_Component(require('Core/Libraries/ECS/Components/Collisions/c_Bounding_Box').new(0, 0, 8, 8))
                  bullet:Add_Component(require('Core/Libraries/ECS/Components/Collisions/c_Box_Collider').new())
                  local body = bullet:Add_Component(require('Core/Libraries/ECS/Components/Collisions/c_Simple_Body').new())
                        body.isSolid = false
                 
                  bullet:Add_Component(require('Core/Libraries/ECS/Components/Rendering/c_Trail_Emitter').new())
                  bullet:Add_Component(require('Core/Libraries/ECS/Components/Rendering/c_Sprite_Renderer').new("Game/Images/Projectiles/tank_bullet.png"))
                  bullet.name = "bullet"

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