return {
    new = function()
        local Class = {
            ahead    = Vector2.new(),
            isLook   = true,
            maxDist  = 48,
            position = Vector2.new(),         
            speed    = 0.1
        }  

        -------------------
        -- Follow_Target --
        -------------------
        function Class:Follow_Target(_pTarget)           
            if(self.isLook) then
                local w = love.graphics.getWidth()
                local h = love.graphics.getHeight()
                local sx, sy = love.mouse.getPosition()
                local mx, my = Screen_To_World(love.mouse.getPosition())
                if(sx > 0 and sx < w and
                   sy > 0 and sy < h) then
                    local dir  = _pTarget.position:DirectionTo({x = mx, y = my})
                    local dist = _pTarget.position:Distance({x = mx, y = my})
                    self.ahead:Set(
                        _pTarget.position.x + (math.cos(dir) * math.min(dist, self.maxDist)),
                        _pTarget.position.y + (math.sin(dir) * math.min(dist, self.maxDist))
                    )
                    self.position.x = Lerp(self.position.x, self.ahead.x, self.speed)
                    self.position.y = Lerp(self.position.y, self.ahead.y, self.speed)
                else
                    self.position.x = Lerp(self.position.x, _pTarget.position.x, self.speed)
                    self.position.y = Lerp(self.position.y, _pTarget.position.y, self.speed)            
                end
            else
                self.position.x = Lerp(self.position.x, _pTarget.position.x, self.speed)
                self.position.y = Lerp(self.position.y, _pTarget.position.y, self.speed)
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