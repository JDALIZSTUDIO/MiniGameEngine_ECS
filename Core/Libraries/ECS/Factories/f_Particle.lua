return {
    new = function()
        local Class            = {
            active             = false,
            color              = { 1, 1, 1, 1 },
            colors             = { {1, 1, 1, 1}, {1, 1, 1, 1}, {1, 1, 1, 1} },
            friction           = { x = 0, y = 0 },
            gravity            = { x = 0, y = 0 },
            isShadow           = false,
            lifeTime           = { 1, 1 },
            lifeRemaining      = 0,
            position           = { x = 0, y = 0 },
            rotation           = 0,
            shadow             = 0,
            size               = 1,
            sizes              = { 1, 1, 1 },
            sprite             = nil,
            sizeVariation      = 1,
            spinVariation      = 1,
            velocity           = { x = 0, y = 0 }
        }

        local atan2 = math.atan2
        local cos   = math.cos
        local sin   = math.sin
        local sqrt  = math.sqrt
        local floor = math.floor
        local rad   = math.rad
        
        ------------
        -- Update --
        ------------
        function Class:Update(dt)
            self.lifeRemaining = self.lifeRemaining - dt
            if(self.lifeRemaining <= 0) then 
                self.active        = false
                self.lifeRemaining = 0 
            else
                local percent = self.lifeRemaining / self.lifeTime
                local speed   = ((self.lifeTime) * dt)
                
                self:Update_Color(dt, percent, speed)
                self:Update_Size(dt, percent, speed)
                self:Update_Rotation(dt)
                self:Apply_Gravity()
                self:Update_Position(dt)
            end
        end

        ------------------
        -- Update_Color --
        ------------------
        function Class:Update_Color(dt, _pPercent, _pSpeed)
            local count   = #self.colors
            local index   = floor((1 - _pPercent) * count) + 1
            local current = self.colors[index]
            for i = 1, #current do
                self.color[i] = self.color[i] + ((current[i] - self.color[i]) * _pSpeed)
            end           
        end
        
        ---------------------
        -- Update_Rotation --
        ---------------------
        function Class:Update_Rotation(dt)
            self.rotation = self.rotation + self.spinVariation * dt
        end
        
        -----------------
        -- Update_Size --
        -----------------
        function Class:Update_Size(dt, _pPercent, _pSpeed)
            local count   = #self.sizes
            local index   = floor((1 - _pPercent) * count) + 1
            local current = self.sizes[index]
            self.size     = self.size + ((current - self.size) * _pSpeed)        
        end
        
        -------------------
        -- Apply_Gravity --
        -------------------
        function Class:Apply_Gravity()
            self.velocity = {
                x = self.velocity.x + self.gravity.x,
                y = self.velocity.y + self.gravity.y
            }            
        end

        ---------------------
        -- Update_Position --
        ---------------------
        function Class:Update_Position(dt)
            local direction = atan2(0 - self.velocity.y, 0 - self.velocity.x)
            local magnitude = sqrt(self.velocity.x * self.velocity.x + self.velocity.y * self.velocity.y)
            local dx = cos(direction) * magnitude
            local dy = sin(direction) * magnitude
            self.position = {
                x = self.position.x + dx * dt,
                y = self.position.y + dy * dt
            }
        end
        
        ----------
        -- Draw --
        ----------
        function Class:Draw()
            if(self.isShadow) then
                self:Draw_Dropshadow()
            end

            love.graphics.setColor(self.color)
            love.graphics.draw(
                self.sprite.image,
                self.position.x, 
                self.position.y,
                rad(self.rotation),
                self.size,
                self.size,
                self.sprite.halfW,
                self.sprite.halfH
            )
        end

        function Class:Draw_Dropshadow()
            love.graphics.setColor(0, 0, 0, self.color[4] * 0.3)
            love.graphics.draw(
                self.sprite.image,
                self.position.x + self.shadow, 
                self.position.y + self.shadow,
                rad(self.rotation),
                self.size,
                self.size,
                self.sprite.halfW,
                self.sprite.halfH
            )

        end
        
        return Class
    end
}