return {
    new = function()
        local Class            = {
            active             = false,
            color              = { 1, 1, 1, 1 },
            colors             = { {1, 1, 1, 1}, {1, 1, 1, 1}, {1, 1, 1, 1} },
            friction           = { x = 0, y = 0 },
            gravity            = { x = 0, y = 0 },
            lifeTime           = { 1, 1 },
            lifeRemaining      = 0,
            position           = { x = 0, y = 0 },
            rotation           = 0,
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
        
        ----------------
        -- local Lerp --
        ----------------
        local function lerp(_pInitial, _pTarget, _pSpeed)
            return _pInitial - (_pInitial - _pTarget) * _pSpeed
        end

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
                
                self:Update_Color(dt, percent)
                self:Update_Rotation(dt)
                self:Update_Size(dt, percent)
                self:Apply_Gravity()
                self:Update_Position(dt)
            end
        end

        ------------------
        -- Update_Color --
        ------------------
        function Class:Update_Color(dt, _pPercent)
            local count   = #self.colors
            local index   = floor((1 - _pPercent) * count) + 1
            local current = self.colors[index]
            local speed   = (self.lifeTime / count) * dt
            for i = 1, #current do
                self.color[i] = lerp(self.color[i], current[i], speed)
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
        function Class:Update_Size(dt, _pPercent)
            local count   = #self.sizes
            local index   = floor(_pPercent * count) + 1
            local current = self.sizes[index]
            local speed   = (self.lifeTime / count) * dt
            self.size     = lerp(self.size, current, speed)         
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
        
        return Class
    end
}