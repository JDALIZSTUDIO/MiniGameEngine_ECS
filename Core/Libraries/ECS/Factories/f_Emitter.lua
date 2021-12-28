return {
    new = function(_pX, _pY)
        local factory = Locator:Get_Service("f_particle")
        local Class      = {
            expired      = false,
            lstActive    = {},
            lstInactive  = {},
            maxParticles = 32,
            position     = { 
                x = _pX, 
                y = _pY 
            }
        }

        local insert = table.insert
        local remove = table.remove

        ---------------
        -- Get_Count --
        ---------------
        function Class:Get_Count()
            return #self.lstActive
        end

        ----------------
        -- Initialize --
        ----------------
        function Class:Initialize()
            local particle
            for i = 1, self.maxParticles do
                particle = factory.new()
                insert(self.lstInactive, particle)
            end
        end

        --------------------
        -- Set_Parameters --
        --------------------
        function Class:Set_Parameters(_pParameters)
            
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

        ------------
        -- Update --
        ------------
        function Class:Update(dt)
            local particle
            for i = #self.lstActive, 1, -1 do
                particle = self.lstActive[i]                
                if(particle.lifeRemaining == 0) then
                    insert(self.lstInactive, remove(self.lstActive, i))
                else
                    particle:Update(dt)
                end 
            end
        end
        
        ----------
        -- Draw --
        ----------
        function Class:Draw()
            local particle
            for i = 1, #self.lstActive do
                particle = self.lstActive[i]                
                particle:Draw()
            end
        end

        Class:Initialize()

        return Class
    end
}