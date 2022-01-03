return {
    new = function() 
        local f_system = Locator:Get_Service("f_system")
        local system   = f_system.new({"health"})

        local he = "health"

        ----------
        -- Load --
        ----------
        function system:Load(_pEntity)
            local component = _pEntity:Get_Component(he)
                  component:Load()
            if(isDebug) then print("Systems, loaded:      s_Health by ".._pEntity.name) end
        end

        ------------
        -- Update --
        ------------
        function system:Update(dt, _pEntity)
            local component = _pEntity:Get_Component(he)
                  component:Update(dt)
        end

        ----------
        -- Draw --
        ----------
        function system:Draw(_pEntity)
            local component = _pEntity:Get_Component(he)
                  component:Draw()
        end

        --------------
        -- Draw_GUI --
        --------------
        function system:Draw_GUI(_pEntity)
            local component = _pEntity:Get_Component(he)
                  component:Draw_GUI()
        end

        return system 
    end
  }