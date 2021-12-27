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
        local transform = self.gameObject:Get_Component(tr)
        local emitter   = self.gameObject:Get_Component(fx)
              emitter:Emit("Game/Images/FX/explosion_100x100_n59.png", 
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