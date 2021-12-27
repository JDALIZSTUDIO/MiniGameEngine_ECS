return {
    new = function() 
        local system = p_System.new({"transform", "particleSystem"})

        local ps = "particleSystem"

        ----------
        -- Load --
        ----------
        function system:Load(_pEntity)
            if(isDebug) then print("Systems, loaded:      s_Particle_System by ".._pEntity.name) end
        end

        ------------
        -- Update --
        ------------
        function system:Update(dt, _pEntity)
            local component = _pEntity:Get_Component(ps)
                  component:Update(dt, _pEntity)
        end

        ----------
        -- Draw --
        ----------
        function system:Draw(_pEntity)
            local component = _pEntity:Get_Component(ps)
                  component:Draw(_pEntity)
        end

        --------------
        -- Draw_GUI --
        --------------
        function system:Draw_GUI(_pEntity)
            local component = _pEntity:Get_Component(ps)
                  component:Draw_GUI(_pEntity)
        end

        return system 
    end
  }