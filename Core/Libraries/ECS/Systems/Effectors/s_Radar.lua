return {
    new = function() 
        local f_system = Locator:Get_Service("f_system")
        local system   = f_system.new({"transform", "radar"})

        local ra = "radar"

        ----------
        -- Load --
        ----------
        function system:Load(_pEntity)
            if(isDebug) then print("Systems, loaded:      s_Radar by ".._pEntity.name) end
        end

        ------------
        -- Update --
        ------------
        function system:Update(dt, _pEntity)
            local component = _pEntity:Get_Component(ra)
                  component:Update(dt)
        end

        ----------
        -- Draw --
        ----------
        function system:Draw(_pEntity)
            local component = _pEntity:Get_Component(ra)
                  component:Draw()
        end

        return system 
    end
  }