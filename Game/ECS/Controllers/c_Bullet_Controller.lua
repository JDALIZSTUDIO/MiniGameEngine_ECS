local factory  = require('Core/Libraries/ECS/Components/Controllers/c_Parent_Controller')

return {
  new = function(_pParamaters)
    local params = _pParamaters or {}
    
    local component             = factory.new()
          component.damage      = params.damage or 20
          component.maxDistance = 192
          component.maxSpeed    = 260
          component.owner       = params.owner or nil

    local origin
    local toDestroy = false

    local impactPath

    local rad = math.rad
    local rnd = math.random
    local cos = math.cos
    local sin = math.sin

    local tr = "transform"
        
    -----------------
    -- Custom_Load --
    -----------------
    function component:Custom_Load()
        local transform = self.gameObject:Get_Component(tr)
        local rot       = rad(transform.rotation)
                transform.velocity:Set(
            cos(rot) * self.maxSpeed,
            sin(rot) * self.maxSpeed
        )
        origin = Vector2.new(transform.position.x, transform.position.y)
        impactPath = "Game/Images/FX/impact_bullet_48x48.png"
    end
    
    ----------------
    -- On_Destroy --
    ----------------
    function component:On_Destroy()
        self:Create_Impact()
    end

    ------------------
    -- Update_Logic --
    ------------------
    function component:Update_Logic(dt)
        local transform = self.gameObject:Get_Component(tr) 
        local dist = transform.position:Distance_To(origin)
        if(dist > self.maxDistance) then 
            if(toDestroy == false) then
                component.gameObject.Destroy() 
                toDestroy = true
            end
        end
    end

    -------------------
    -- Create_Impact --
    -------------------
    function component:Create_Impact()
        local transform = self.gameObject:Get_Component(tr)
        local impact = self.gameObject.ECS:Create()
              impact:Add_Component(require('Game/ECS/Controllers/c_FX_Controller').new())
              impact:Add_Component(require('Core/Libraries/ECS/Components/Movement/c_Transform').new(transform.position.x, 
                                                                                                     transform.position.y, 
                                                                                                     rnd(359)))
              impact:Add_Component(require('Core/Libraries/ECS/Components/Collisions/c_Bounding_Box').new(0, 0, 16, 16))
        local anim = impact:Add_Component(require('Core/Libraries/ECS/Components/Rendering/c_Animator').new())
              anim:Add("run", impactPath, 48, 48, 0, 0, 1, 1, 36, 1, 60, false)
    end

    -----------------------
    -- On_Entity_Collision --
    -----------------------
    function component:On_Entity_Collision(_pTable)
        --self.gameObject:Destroy()        
    end
    
    ---------------------
    -- On_Tile_Collision --
    ---------------------
    function component:On_Tile_Collision(_pTileID)
        self.gameObject:Destroy()
        --self:Create_Impact()
    end
    
    return component
  end
}