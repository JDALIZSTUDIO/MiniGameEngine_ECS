return {
    new = function()
        local f_component = Locator:Get_Service("f_component")
        local component = f_component.new("radar")
                component.active       = true
                component.alpha        = 0
                component.alphaDetect  = 0.2
                component.color        = {1, 1, 1}
                component.color_clear  = {0, 1, 0}
                component.color_detect = {1, 0, 0}
                component.isDetect     = false
                component.segments     = 32
                component.speed        = 0.1
                component.viewAngle    = math.rad(45)
                component.viewDistance = 128
        
        local rad       = math.rad
        local state     = nil
        local timers    = nil
        local tName     = "wait"
        local tDuration = 3
        local lerp      = Lerp
        local tr        = "transform"

        ----------
        -- Load --
        ----------
        function component:Load()
            state  = Locator:Get_Service("state_machine").new(
                {
                    "SHOW", 
                    "HIDE"
                }
            )
            timers = Locator:Get_Service("timers").new()
            timers:Add_Timer(tName, tDuration)        
            state:Set("HIDE")
        end

        ----------
        -- Scan --
        ----------
        function component:Scan(_pX, _pY)
            local transform  = self.gameObject:Get_Component(tr)

            local pos = { x  = _pX, y = _pY }
            local distance   = transform.position:Distance_To(pos)

            if(distance < self.viewDistance) then
                local rot       = rad(transform.rotation)
                local direction = transform.position:Direction_From(pos)
                local dAngle    = ((direction - rot + math.pi)%(2*math.pi)-math.pi)
                local inSight   = dAngle < 0.5*self.viewAngle
                if(inSight) then
                    self.isDetect = true
                    return true
                end
                return false
            else
                self.isDetect = false
            end
            return false
        end

        ------------
        -- Update --
        ------------
        function component:Update(dt)
            if(self.active) then
                self:Update_Active(dt)
                self:Update_Color(dt)
            else
                self:Update_Inactive(dt)
            end  
            timers:Update(dt)
        end

        ------------------
        -- Update_Color --
        ------------------
        function component:Update_Color(dt)
            local color
            if(self.isDetect) then            
                color = self.color_detect
            else
                color = self.color_clear
            end

            for i = 1, #color do
                self.color[i] = lerp(self.color[i], color[i], self.speed)
            end        
        end

        -------------------
        -- Update_Active --
        -------------------
        function component:Update_Active(dt)
            if(self.alpha < 0.99) then            
                self.alpha = lerp(
                    self.alpha, 
                    self.alphaDetect, 
                    self.speed
                )
            else
                self.alpha = 1
            end
        end

        ---------------------
        -- Update_Inactive --
        ---------------------
        function component:Update_Inactive(dt)          
            if(self.alpha > 0.01) then
                self.alpha = lerp(
                    self.alpha, 
                    0, 
                    self.speed
                )
            else
                self.alpha = 0
            end
        end

        ----------
        -- Draw --
        ----------
        function component:Draw()
            local transform = self.gameObject:Get_Component(tr)
            local angle     = rad(transform.rotation - 90)
            local r, g, b   = unpack(self.color)
            love.graphics.setColor(r, g, b, self.alpha)
            love.graphics.arc("fill", 
                transform.position.x, 
                transform.position.y, 
                self.viewDistance, 
                angle - self.viewAngle, 
                angle + self.viewAngle,
                self.segments            
            )

            love.graphics.setColor(1, 1, 1, self.alpha)

            love.graphics.arc("line", 
                transform.position.x, 
                transform.position.y, 
                self.viewDistance, 
                angle - self.viewAngle, 
                angle + self.viewAngle,
                self.segments            
            )

            love.graphics.setColor(1, 1, 1, 1)
        end        

        component:Load()

        return component
    end
  }