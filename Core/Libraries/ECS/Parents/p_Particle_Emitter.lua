return {
    new = function(_pX, _pY)
        local Class      = {
            lstParticles = {},
            position     = { 
                x = _pX, 
                y = _pY 
            }
        }

        ---------------
        -- Get_Count --
        ---------------
        function Class:Get_Count()
            return #self.lstParticles
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