return {
    new = function(_pSprite)
        local Class = {
            position = nil,
            scale    = nil,
            sprite   = _pSprite,
            shader   = nil,
            surface  = nil,
        }

        local aspect
        local amplitude = 1

        local screenW = love.graphics.getWidth()
        local screenH = love.graphics.getHeight()

        local center = {
            x = screenW  * 0.5,
            y = screenH * 0.5
        }

        local floor = math.floor
        local rad   = math.rad
        local cos   = math.cos
        local sin   = math.sin
        local time  = 0

        function Class:Load()
            aspect = Locator:Get_Service("aspect")
            self.scale   = {
                x = 1,
                y = 1
            }
            self.shader  = Locator:Get_Service("shaders").new("Core/Shaders/shd_scrolling.fs")
            self.surface = love.graphics.newCanvas(
                love.graphics.getWidth(),
                love.graphics.getHeight()
            )

            self.surface:setFilter("nearest", "nearest")
        end

        function Class:Update(dt)
            time = time + dt
            local angle = rad(time)

            local dX =  ((cos(time)*0.5)+0.5) * (amplitude * cos(time))
            local dY = -((sin(time)*0.5)+0.5) * (amplitude * sin(time))

            self.shader:SetUniform("tX",  0)
            self.shader:SetUniform("tY", -time*0.1)
        end

        function Class:Draw()
            love.graphics.setColor(1, 1, 1, 0.5)
            love.graphics.setCanvas(self.surface)
            local nbCol = floor(screenW  / self.sprite.width)+1
            local nbLig = floor(screenH / self.sprite.height)+1
            for yy = 1, nbLig do
                for xx = 1, nbCol do
                    love.graphics.draw(
                        self.sprite.image,
                        self.sprite.width  * (xx - 1),
                        self.sprite.height * (yy - 1)
                    )
                end
            end
            love.graphics.setCanvas()
            
            self.shader:Set()
                love.graphics.draw(self.surface, 0, 0)

            self.shader:UnSet()
        end
        
        Class:Load()

        return Class
    end
}