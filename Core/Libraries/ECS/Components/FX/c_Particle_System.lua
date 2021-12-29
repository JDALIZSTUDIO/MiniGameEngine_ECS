return {
    new = function(_pImagePath)
        local f_component = Locator:Get_Service("f_component")
        local f_emitter   = Locator:Get_Service("f_emitter") --require('Core/Libraries/ECS/Parents/p_Particle_Emitter')        
        local component   = f_component.new("particleSystem")
              component.emitters = {}
        
        local insert = table.insert
        local remove = table.remove
        local min    = math.min
        local rnd    = math.random
        
        local tr  = "transform"

        ------------
        -- Create --
        ------------
        function component:Create(_pName)
            self.emitters[_pName] = f_emitter.new()
            return self:Get_Emitter(_pName)
        end
        
        ----------
        -- Emit --
        ----------
        function component:Emit(_pName, _pX, _pY, _pNumber)
            local emitter = self.emitters[_pName]
            if(emitter ~= nil) then
                emitter:Emit(_pX, _pY, _pNumber) 
            end
        end

        -----------------
        -- Get_Emitter --
        -----------------
        function component:Get_Emitter(_pName)
            return self.emitters[_pName]
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

        ------------
        -- Remove --
        ------------
        function component:Remove(_pName)
            local emitter = self.emitters[_pName]
            if(emitter ~= nil) then emitter.expired = true end
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
            for key, value in pairs(self.emitters) do
                if(value.expired) then
                    remove(self.emitters, key)
                else
                    value:Update(dt)
                end
            end
        end

        ----------
        -- Draw --
        ----------
        function component:Draw()
            for key, value in pairs(self.emitters) do
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