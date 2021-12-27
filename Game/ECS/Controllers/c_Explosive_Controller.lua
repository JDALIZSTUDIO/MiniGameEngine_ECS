local factory = require('Game/ECS/Controllers/c_Destructible_Controller')

return {
  new = function()
    local component = factory.new()
    
    local rnd = math.random
    local fx  = "animatedFxEmitter"
    local tr  = "transform"
    
    -------------
    -- Explode --
    -------------
    function component:Explode()
        local spr_explosion = Locator:Get_Service("spriteLoader"):Get_Sprite("explosion1")
        local transform = self.gameObject:Get_Component(tr)
        local emitter   = self.gameObject:Get_Component(fx)
              emitter:Emit(spr_explosion, 
                           100, 
                           100, 
                           0, 
                           0, 
                           1, 
                           1, 
                           59, 
                           1)
    end
  
    return component
  end
}