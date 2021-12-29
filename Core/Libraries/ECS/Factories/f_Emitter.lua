return {
    new = function()
        local f_particle = Locator:Get_Service("f_particle")
        local Class      = {
            expired      = false,
            lstActive    = {},
            lstParticles = {},
            maxParticles = 200,
            parameters   = {},
            position     = { 
                x        = _pX, 
                y        = _pY 
            }
        }

        local max    = math.max
        local min    = math.min
        local rnd    = math.random
        local insert = table.insert
        local remove = table.remove

        ----------
        -- Emit --
        ----------
        function Class:Emit(_pX, _pY, _pNumber)
            self.position = {
                x = _pX,
                y = _pY
            }
            
            local count     = #self.lstParticles
            local available = count - #self.lstActive
            local counter = 0, particle
            for i = 1, count do
                if(counter < _pNumber and counter < available) then
                    particle = self.lstParticles[i]
                    if(particle.active == false) then              
                        insert(self.lstActive, self:Init_Particle(particle))
                        counter = counter + 1
                    end
                else
                    return
                end
            end
        end

        ---------------
        -- Get_Count --
        ---------------
        function Class:Get_Count()
            return #self.lstActive
        end
        
        -------------------
        -- Init_Particle --
        -------------------
        function Class:Init_Particle(_pParticle)
            if(_pParticle == nil) then return end
            _pParticle.active             = true

            _pParticle.colors = {}
            for i = 1, #self.parameters.colors do
                _pParticle.colors[i] = {}
                for j = 1, #self.parameters.colors[i] do
                    _pParticle.colors[i][j] = self.parameters.colors[i][j]
                end
            end

            _pParticle.color = {}
            for i = 1, #self.parameters.colors[1] do
                _pParticle.color[i] = self.parameters.colors[1][i]
            end

            _pParticle.lifeTime           = rnd(
                self.parameters.lifeTime[1], 
                self.parameters.lifeTime[2]
            )
            _pParticle.lifeRemaining      = _pParticle.lifeTime
            _pParticle.velocity           = {
                x = rnd(self.parameters.linearAcceleration[1], self.parameters.linearAcceleration[2]),
                y = rnd(self.parameters.linearAcceleration[3], self.parameters.linearAcceleration[4])
            }
            _pParticle.gravity            = {
                x = rnd(self.parameters.linearDampening[1], self.parameters.linearDampening[2]),
                y = rnd(self.parameters.linearDampening[3], self.parameters.linearDampening[4])
            }
            _pParticle.position           = {
                x = self.position.x + rnd(self.parameters.offset[1], self.parameters.offset[2]),
                y = self.position.y + rnd(self.parameters.offset[3], self.parameters.offset[4])
            }
            _pParticle.rotation           = rnd(
                self.parameters.rotation[1], 
                self.parameters.rotation[2]
            )

            for i = 1, #self.parameters.sizes do
                _pParticle.sizes[i]       = self.parameters.sizes[i]
            end

            _pParticle.size               = _pParticle.sizes[1]
            _pParticle.sprite             = self.parameters.sprite
            _pParticle.sizeVariation      = rnd(
                self.parameters.sizeVariation[1], self.parameters.sizeVariation[2]
            )
            _pParticle.spinVariation      = rnd(
                self.parameters.spinVariation[1], self.parameters.spinVariation[2]
            )
            return _pParticle
        end

        ----------------
        -- Initialize --
        ----------------
        function Class:Initialize()
            local particle
            for i = 1, self.maxParticles do
                particle = f_particle.new()
                insert(self.lstParticles, particle)
            end
        end
        
        -------------------
        -- Resize_Buffer --
        -------------------
        function Class:Resize_Buffer(_pMax)
            if(_pMax > self.maxParticles) then
                local count  = _pMax + self.maxParticles
                for i = 1, count do
                    particle = f_particle.new()
                    insert(self.lstParticles, particle)
                end
            end
            self.maxParticles = _pMax
        end

        --------------------
        -- Set_Parameters --
        --------------------
        function Class:Set_Parameters(_pParameters)
            for key, value in pairs(_pParameters) do
                self.parameters[key] = value
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

        ------------
        -- Update --
        ------------
        function Class:Update(dt)
            local particle
            local lstActive = self.lstActive
            for i = #lstActive, 1, -1 do
                particle = lstActive[i]                
                if(particle.active == false) then
                    remove(lstActive, i)
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
            local lstActive = self.lstActive
            for i = 1, #lstActive do
                particle = lstActive[i]
                particle:Draw()
            end
            love.graphics.setColor(1, 1, 1, 1)
        end

        Class:Initialize()

        return Class
    end
}