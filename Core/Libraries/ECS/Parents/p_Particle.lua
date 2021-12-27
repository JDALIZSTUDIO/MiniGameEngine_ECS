return {
    new = function(_pX, _pY)
        local Class = {
            colors             = { {1, 1, 1, 1}, {1, 1, 1, 1}, {1, 1, 1, 1} },
            lifeTime           = { 1, 1 },
            lifeRemaining      = 0,  
            linearAcceleration = { 0, 0, 0, 0 },
            linearDampening    = { 0, 0, 0, 0 },
            position           = { x = _pX, y = _pY },
            rotation           = { 0, 0, 0 },
            sizes              = { 1, 1, 1 },
            speed              = { 0, 0, 0 },
            sprite             = {
                image          = nil,
                width          = 0,
                height         = 0,
                halfW          = 0,
                halfH          = 0
            },
            sizeVariation      = 0,
            spinVariation      = 0
        }

        ----------
        -- Load --
        ----------
        function Class:Load()

        end
        
        ----------------
        -- Set_Sprite --
        ----------------
        function Class:Set_Sprite(_pImage)
            local width  = _pImage:getWidth()
            local height = _pImage:getHeight()
            local halfW  = width * 0.5
            local halfH  = height * 0.5
            self.sprite = {
                image  = _pImage,
                width  = width,
                height = height,
                halfW  = halfW,
                halfH  = halfH
            }
        end
        
        ------------
        -- Update --
        ------------
        function Class:Update(dt)

        end
        
        ----------
        -- Draw --
        ----------
        function Class:Draw()

        end

    end
}