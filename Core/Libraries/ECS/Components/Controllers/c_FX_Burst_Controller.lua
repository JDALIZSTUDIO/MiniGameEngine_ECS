return {
    new = function()
        local f_controller         = Locator:Get_Service("f_controller")
        local component            = f_controller.new()
              component.active     = false
              component.parameters = {} 
              component.area       = {}
              component.duration   = 0
              component.count      = 0
            
        local an     = "animator"
        local fx     = "animatedFxEmitter"
        local tr     = "transform"
        local count  = 0
        local rnd    = math.random
        local timers

        local expired = false
        local tStr    = "timer"
        ----------
        -- Emit --
        ----------
        function component:Emit(
            _pX,
            _pY,
            _pSprite, 
            _pFrameW, 
            _pFrameH,
            _pStartCol, 
            _pStartLig, 
            _pEndCol, 
            _pEndLig, 
            _pSpeed,
            _pSX,
            _pSY
        )
            local f_FX = Locator:Get_Service("f_fx")
            local fx   = self.gameObject.ECS:Create()
                  fx:Add_Component(f_FX.new())
                  fx:Add_Component(require('Core/Libraries/ECS/Components/FX/c_Animated_FX_Controller').new())
                local t = fx:Add_Component(require('Core/Libraries/ECS/Components/Movement/c_Transform').new(
                    _pX, 
                    _pY, 
                    rnd(359))
                )

                fx:Add_Component(require('Core/Libraries/ECS/Components/Collisions/c_Bounding_Box').new(0, 0, 16, 16))
            local anim = fx:Add_Component(require('Core/Libraries/ECS/Components/Rendering/c_Animator').new())
                  anim:Add("run", _pSprite, _pFrameW, _pFrameH, 0, 0, _pStartCol, _pStartLig, _pEndCol, _pEndLig, _pSpeed or 120, false)
        end

        -----------
        -- Start --
        -----------
        function component:Start(_pParams, _pArea, _pDuration, _pCount)
            self.parameters = {
                sprite      = _pParams.sprite,
                width       = _pParams.width,
                height      = _pParams.height,
                col1        = _pParams.col1,
                lig1        = _pParams.lig1,
                col2        = _pParams.col2,
                lig2        = _pParams.lig2,
                speed       = _pParams.speed,                
            } 
            self.area       = _pArea
            self.duration   = _pDuration
            self.count      = _pCount
            self.active     = true

            timers = Locator:Get_Service("timers").new()
            timers:Add_Timer(tStr, self.duration)    
        end     

        ---------------
        -- On_Update --
        ---------------
        function component:On_Update(dt)
            if(not self.active or self.expired) then return end
            
            if(timers:Is_Finished(tStr)) then
                local transform = self.gameObject:Get_Component(tr)
                local w         = rnd(-self.area.width  * 0.5, self.area.width  * 0.5)
                local h         = rnd(-self.area.height * 0.5, self.area.height * 0.5)
                local x         = transform.position.x + w
                local y         = transform.position.y + h

                self:Emit( 
                    x, 
                    y,
                    self.parameters.sprite, 
                    self.parameters.width, 
                    self.parameters.height,
                    self.parameters.col1,
                    self.parameters.lig1, 
                    self.parameters.col2, 
                    self.parameters.lig2,
                    self.parameters.speed
                )

                count = count + 1
                timers:Start(tStr)
            end

            if(count >= self.count) then 
                self.gameObject:Destroy() 
                expired = true 
            end
            timers:Update(dt)    
        end
        
        return component
    end
  }