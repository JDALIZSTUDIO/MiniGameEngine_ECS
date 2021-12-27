return {
    new = function()
        local Class = {
            color   = {1, 1, 1, 0.35},
            image   = nil,
            width   = nil,
            height  = nil,
            scaleX  = nil,
            scaleY  = nil
        }

        -----------------
        -- Set_Texture --
        -----------------
        function Class:Set_Texture(_pPath)
            self.image = love.graphics.newImage(_pPath)
        end

        ---------------
        -- Set_Color --
        ---------------
        function Class:Set_Color(_pColor)
            self.color = _pColor or {1, 1, 1, 0.35}
        end

        ------------
        -- Update --
        ------------
        function Class:Update(dt)
            self.scaleX = love.graphics.getWidth()  / self.image:getWidth()
            self.scaleY = love.graphics.getHeight() / self.image:getHeight()
        end

        ----------
        -- Draw --
        ----------
        function Class:Draw()
            love.graphics.setColor(self.color)
                love.graphics.draw(
                    self.image, 
                    0, 
                    0, 
                    0, 
                    self.scaleX, 
                    self.scaleY
                )
            love.graphics.setColor(1, 1, 1, 1)
        end

        return Class
    end
}