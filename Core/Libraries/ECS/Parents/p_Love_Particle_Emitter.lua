return {
    new = function(_pParameters)
        local ParticleEmitter = {
            colors             = _pParameters.colors             or {{1, 1, 1, 1}, {1, 1, 1, 1}},
            emitter            = nil,      
            expired            = false,
            image              = _pParameters.image              or nil,
            loaded             = false,      
            lifeTime           = _pParameters.lifeTime           or { 1, 1 },
            lifeRemaining      = 0,  
            linearAcceleration = _pParameters.linearAcceleration or { 0, 0, 0, 0 },
            linearDampening    = _pParameters.linearDampening    or { 0, 0 },   
            maxParticles       = _pParameters.maxParticles       or 32,
            position           = _pParameters.position           or { 0, 0 },
            rotation           = _pParameters.rotation           or { 0, 0 },
            sizes              = _pParameters.sizes              or { 1, 1 },
            speed              = _pParameters.speed              or { 0, 0 },
            sizeVariation      = _pParameters.sizeVariation      or 0,
            spinVariation      = _pParameters.spinVariation      or 0
        }

        local insert = table.insert
        local min    = math.min

        -----------
        -- Merge --
        -----------
        local function Merge(_pTables)
            local result = {}
            local table
            for i = 1, #_pTables do
                table = _pTables[i]
                for j = 1, #table do                
                    insert(result, table[j])
                end
            end
            return result
        end

        ----------
        -- Emit --
        ----------
        function ParticleEmitter:Emit(_pNumber)
            self.emitter:emit(min(_pNumber, self.maxParticles))
        end

        ----------
        -- Load --
        ----------
        function ParticleEmitter:Load()
            if(self.image == nil) then print("particle_system error, image path not found!") end
            self.emitter = love.graphics.newParticleSystem(self.image, self.maxParticles)
            self.emitter:setParticleLifetime(unpack(self.lifeTime))
            self.emitter:setLinearAcceleration(unpack(self.linearAcceleration))
            self.emitter:setLinearDamping(unpack(self.linearDampening))
            self.emitter:setColors(unpack(self.colors))
            self.emitter:setRotation(unpack(self.rotation))
            self.emitter:setSpeed(unpack(self.speed))
            self.emitter:setSizes(unpack(self.sizes))
            self.emitter:setSpinVariation(self.spinVariation)
            self.emitter:setSizeVariation(self.sizeVariation)
            self.emitter:setPosition(unpack(self.position))

            self.emitter:emit(self.maxParticles)

            self.loaded = true
        end

        ------------
        -- Update --
        ------------
        function ParticleEmitter:Update(dt)
            if(self.image == nil) then print("particle_system error, image path not found!") end
            if(self.emitter:getCount() <= 0) then self.expired = true end

            self.emitter:update(dt)
        end

        ----------
        -- Draw --
        ----------
        function ParticleEmitter:Draw()
            if(self.image == nil) then print("particle_system error, image path not found!") end
            love.graphics.draw(self.emitter, unpack(self.position))
        end

        ParticleEmitter:Load()
  
      return ParticleEmitter
    end
  
  }