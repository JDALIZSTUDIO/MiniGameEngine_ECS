local factory = require('Game/ECS/Controllers/c_Destructible_Controller')

return {
  new = function()
    local component = factory.new()
          component.damage = 45
    
    local rnd    = math.random
    local ae     = "areaOfEffect"
    local ch     = "characterController"
    local fx     = "animatedFxEmitter"
    local he     = "health"
    local tr     = "transform"
    
    local function OnExplosion(_pentity)
      if(_pentity == nil or _pentity.expired) then return end
      local controller = _pentity:Get_Component(ch)
      if(controller == nil) then return end
      controller:Hurt(component.damage)
    end

    -------------
    -- Explode --
    -------------
    function component:Explode()
        local spr_explosion = Locator:Get_Service("spriteLoader"):Get_Sprite("explosionBig1")
        local emitter       = self.gameObject:Get_Component(fx)
              emitter:Emit(
                spr_explosion, 
                200, 
                200, 
                0, 
                0, 
                1, 
                1, 
                60, 
                1,
                120
        )
        
        local effector = self.gameObject:Get_Component(ae)
        if(effector == nil) then return end
        
        local transform = self.gameObject:Get_Component(tr)
        if(transform == nil) then return end
        effector:Apply_Effect(transform.position, OnExplosion)
    end
  
    return component
  end
}