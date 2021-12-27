return {
    new = function()
        local component = p_Component.new("animatedFxEmitter")
              component.scale = Vector2.new(1, 1)
        
        local rnd = math.random
        local tr  = "transform"

        ----------
        -- Emit --
        ----------
        function component:Emit(_pPath, _pFrameW, _pFrameH, _pOffsetX, _pOffsetY, _pStartCol, _pStartLig, _pEndCol, _pEndLig, _pSpeed)
            local transform = self.gameObject:Get_Component(tr)
            local explosion = self.gameObject.ECS:Create()
                explosion:Add_Component(require('Core/Libraries/ECS/Components/Controllers/c_FX_Controller').new())
                local t = explosion:Add_Component(require('Core/Libraries/ECS/Components/Movement/c_Transform').new(transform.position.x, 
                                                                                                                transform.position.y, 
                                                                                                                rnd(359)))

                t.scale:Set(
                    self.scale.x,
                    self.scale.y
                )

                explosion:Add_Component(require('Core/Libraries/ECS/Components/Collisions/c_Bounding_Box').new(0, 0, 16, 16))
            local anim = explosion:Add_Component(require('Core/Libraries/ECS/Components/Rendering/c_Animator').new())
                  anim:Add("run", _pPath, _pFrameW, _pFrameH, _pOffsetX, _pOffsetY, _pStartCol, _pStartLig, _pEndCol, _pEndLig, _pSpeed or 120, false)
        end

        function component:Set_Scale(_pSX, _pSY)
            self.scale:Set{
                _pSX,
                _pSY
            }
        end

        return component  
    end
  }