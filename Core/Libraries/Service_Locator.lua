return {
    new = function()
        local Class     = {
            lstServices = {}
        }

        -----------------
        -- Add_Service --
        -----------------
        function Class:Add_Service(_pName, _pService)
            self.lstServices[_pName] = _pService
            if(isDebug) then print("Service_Locator, Added: ".._pName) end          
        end
        
        ------------------
        -- Get_Service --
        ------------------
        function Class:Get_Service(_pName)
            return self.lstServices[_pName]
        end

        return Class
    end
}