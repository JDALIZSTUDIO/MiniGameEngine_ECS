return {
    new = function()
        local f_FX            = Locator:Get_Service("f_fx")
        local f_component     = Locator:Get_Service("f_component")
        local component       = f_component.new("animatedFxEmitter")
              component.scale = Vector2.new(1, 1)
        
        local rnd = math.random
        local tr  = "transform"

        ----------
        -- Emit --
        ----------
        function component:Emit(
            _pSprite, 
            _pFrameW, 
            _pFrameH, 
            _pOffsetX, 
            _pOffsetY, 
            _pStartCol, 
            _pStartLig, 
            _pEndCol, 
            _pEndLig, 
            _pSpeed,
            _pSX,
            _pSY
        )
            local transform = self.gameObject:Get_Component(tr)
            local explosion = self.gameObject.ECS:Create()
                  explosion:Add_Component(f_FX.new())
                  explosion:Add_Component(require('Core/Libraries/ECS/Components/FX/c_Animated_FX_Controller').new())
                local t = explosion:Add_Component(require('Core/Libraries/ECS/Components/Movement/c_Transform').new(transform.position.x + _pOffsetX, 
                                                                                                                    transform.position.y + _pOffsetY, 
                                                                                                                    rnd(359)))

                t.scale:Set(
                    _pSX or self.scale.x,
                    _pSY or self.scale.y
                )

                explosion:Add_Component(require('Core/Libraries/ECS/Components/Collisions/c_Bounding_Box').new(0, 0, 16, 16))
            local anim = explosion:Add_Component(require('Core/Libraries/ECS/Components/Rendering/c_Animator').new())
                  anim:Add("run", _pSprite, _pFrameW, _pFrameH, _pOffsetX, _pOffsetY, _pStartCol, _pStartLig, _pEndCol, _pEndLig, _pSpeed or 120, false)
        end

        return component  
    end
  }