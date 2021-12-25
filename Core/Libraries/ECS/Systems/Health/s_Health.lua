return {
    new = function() 
        local system = p_System.new({"health"})

        local he = "health"

        ----------
        -- Load --
        ----------
        function system:Load(_pEntity)
        local component = _pEntity:Get_Component(he)
              component:Load(_pEntity)
        if(isDebug) then print("Systems, loaded:      s_Health by ".._pEntity.name) end
        end

        ------------
        -- Update --
        ------------
        function system:Update(dt, _pEntity)
        local component = _pEntity:Get_Component(he)
              component:Update(dt, _pEntity)
        end

        ----------
        -- Draw --
        ----------
        function system:Draw(_pEntity)
        local component = _pEntity:Get_Component(he)
              component:Draw(_pEntity)
        end

        --------------
        -- Draw_GUI --
        --------------
        function system:Draw_GUI(_pEntity)
        local component = _pEntity:Get_Component(he)
              component:Draw_GUI(_pEntity)
        end

        return system 
    end
  }