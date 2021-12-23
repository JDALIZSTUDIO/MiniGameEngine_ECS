return {
    new = function(_pCamera)
        local Class = {
            ahead    = Vector2.new(),
            isLook   = true,
            maxDist  = 32,
            position = Vector2.new(),         
            speed    = 0.05
        }  

        local camera = _pCamera

        local cos    = math.cos
        local sin    = math.sin
        local min    = math.min

        -------------------
        -- Follow_Target --
        -------------------
        function Class:Follow_Target(_pTarget)  
            local lerp = Lerp 

            if(self.isLook) then
                local w = love.graphics.getWidth()
                local h = love.graphics.getHeight()
                local sx, sy = love.mouse.getPosition()
                local mx, my = camera:Screen_To_World(sx, sy)
                if(sx > 0 and sx < w and
                   sy > 0 and sy < h) then
                    local dir    = _pTarget.position:DirectionTo({x = mx, y = my})
                    local dist   = _pTarget.position:Distance({x = mx, y = my})
                    local result = min(dist, self.maxDist)
                    self.ahead:Set(
                        _pTarget.position.x + (cos(dir) * result),
                        _pTarget.position.y + (sin(dir) * result)
                    )
                    self.position.x = lerp(self.position.x, self.ahead.x, self.speed)
                    self.position.y = lerp(self.position.y, self.ahead.y, self.speed)
                else
                    self.position.x = lerp(self.position.x, _pTarget.position.x, self.speed)
                    self.position.y = lerp(self.position.y, _pTarget.position.y, self.speed)            
                end
            else
                self.position.x = lerp(self.position.x, _pTarget.position.x, self.speed)
                self.position.y = lerp(self.position.y, _pTarget.position.y, self.speed)
            end
        end

        ------------------
        -- Set_Position --
        ------------------
        function Class:Set_Position(_pPosition)
            self.position.x = _pPosition.x
            self.position.y = _pPosition.y
        end

        return Class
    end
}