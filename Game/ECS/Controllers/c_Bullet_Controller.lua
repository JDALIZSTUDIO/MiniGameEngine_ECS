return {
  new = function(_pParamaters)
    local f_controller = Locator:Get_Service("f_controller")
    local params       = _pParamaters or {}
    
    local component             = f_controller.new()
          component.damage      = params.damage or 20
          component.maxDistance = 192
          component.maxSpeed    = 260
          component.owner       = params.owner or nil

    local origin
    local toDestroy = false

    local rad = math.rad
    local rnd = math.random
    local cos = math.cos
    local sin = math.sin

    local fx  = "animatedFxEmitter"
    local tr  = "transform"
        
    -------------------
    -- Create_Impact --
    -------------------
    function component:Create_Impact()
        local spr_impact = Locator:Get_Service("spriteLoader"):Get_Sprite("impact_bullet")
        local emitter    = self.gameObject:Get_Component(fx)
              emitter:Emit(spr_impact, 
                           48, 
                           48, 
                           0, 
                           0, 
                           1, 
                           1, 
                           36, 
                           1)
    end

    ----------
    -- Load --
    ----------
    function component:Load()
        local transform = self.gameObject:Get_Component(tr)
        local rot       = rad(transform.rotation)
                transform.velocity:Set(
            cos(rot) * self.maxSpeed,
            sin(rot) * self.maxSpeed
        )
        origin = Vector2.new(transform.position.x, transform.position.y)
        impactPath = "Game/Images/FX/impact_bullet_48x48_n36.png"
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