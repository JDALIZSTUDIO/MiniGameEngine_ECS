return {
    new = function(_pCamera)
        local Class  = {
            active   = true,
            ahead    = { x = 0, y = 0 },
            isLook   = false,
            maxDist  = 64,
            minDist  = 160,
            position = { 
                x = _pCamera.position.x,
                y = _pCamera.position.y 
            },         
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
            if(not self.active) then return end
            local lerp = Lerp
            if(self.isLook) then
                local w = love.graphics.getWidth()
                local h = love.graphics.getHeight()
                local sx, sy = love.mouse.getPosition()
                local mx, my = camera:Screen_To_World(sx, sy)
                if(sx > 0 and sx < w and
                   sy > 0 and sy < h) then
                    local dir    = _pTarget.position:Direction_From({x = mx, y = my})
                    local dist   = _pTarget.position:Distance_To({x = mx, y = my})
                    local result = min(dist, self.maxDist)
                    self.ahead = {
                        x = _pTarget.position.x + (cos(dir) * result),
                        y = _pTarget.position.y + (sin(dir) * result)
                    }
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
        function Class:Set_Position(_pX, _pY)
            self.position = {
                x = _pX,
                y = _pY
            }
        end

        return Class
    end
}