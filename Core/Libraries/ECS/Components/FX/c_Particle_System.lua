return {
    new = function(_pImagePath)
        local factory   = require('Core/Libraries/ECS/Parents/p_Particle_Emitter')        
        local component = p_Component.new("particleSystem")
              component.emitters = {}
        
        local insert = table.insert
        local remove = table.remove
        local min    = math.min
        local rnd    = math.random
        
        local tr  = "transform"

        ---------
        -- Add --
        ---------
        function component:Add(_pName, _pParameters)
            self.emitters[_pName] = self:_Create_New_Emitter(_pParameters)
        end
        
        ----------
        -- Emit --
        ----------
        function component:Emit(_pName, _pNumber)
            local emitter = self.emitters[_pName]
            if(emitter ~= nil) then emitter:Emit(_pNumber) end
        end

        --------------
        -- Clean_Up --
        --------------
        function component:Clean_Up()
            local emitter
            for i = #self.emitters, 1, -1 do
                emitter = self.emitters[i]
                if(emitter:Get_Count() <= 0) then remove(self.emitters, i) end
            end
        end

        -------------------------
        -- _Create_New_Emitter --
        -------------------------
        function component:_Create_New_Emitter(_pParameters)
            return factory.new(_pParameters)
        end
        
        ------------------
        -- Merge_Tables --
        ------------------
        local function Merge_Tables(_pTables)
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

        ------------------
        -- Set_Position --
        ------------------
        function component:Set_Position(_pName, _pX, _pY)
            local emitter = self.emitters[_pName]
            if(emitter ~= nil) then emitter:Set_Position(_pX, _pY) end
        end

        ------------
        -- Update --
        ------------
        function component:Update(dt)
            self:Clean_Up()
            for key, value in ipairs(self.emitters) do
                value:Update(dt)
            end
        end

        ----------
        -- Draw --
        ----------
        function component:Draw()
            love.graphics.setColor(1, 1, 1, 1)
            for key, value in ipairs(self.emitters) do
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