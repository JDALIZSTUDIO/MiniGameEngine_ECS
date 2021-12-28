return {
    new = function(_pImagePath)
        local factory = Locator:Get_Service("f_component")
        local fEmitter   = require('Core/Libraries/ECS/Parents/p_Love_Particle_Emitter')
        
        local component = factory.new("lParticleSystem")
              component.systems = {}
        
        local insert = table.insert
        local remove = table.remove
        local min    = math.min
        local rnd    = math.random
        
        local tr  = "transform"
        
        ----------
        -- Emit --
        ----------
        function component:Emit(_pParameters)
            insert(self.systems, self:_Return_New_Emitter(_pParameters))
        end

        --------------
        -- Clean_Up --
        --------------
        function component:Clean_Up()
            local system
            for i = #self.systems, 1, -1 do
                system = self.systems[i]
                if(system.emitter:getCount() <= 0) then remove(self.systems, i) end
            end
        end

        -------------------------
        -- _Return_New_Emitter --
        -------------------------
        function component:_Return_New_Emitter(_pParameters)
            return fEmitter.new(_pParameters)
        end

        ------------
        -- Update --
        ------------
        function component:Update(dt)
            self:Clean_Up()
            for key, value in ipairs(self.systems) do
                value:Update(dt)
            end
        end

        ----------
        -- Draw --
        ----------
        function component:Draw()
            love.graphics.setColor(1, 1, 1, 1)
            for key, value in ipairs(self.systems) do
                value:Draw()
            end
        end

        --------------
        -- Draw_GUI --
        --------------
        function component:Draw_GUI()
            
        end

        return component  
    end
  }