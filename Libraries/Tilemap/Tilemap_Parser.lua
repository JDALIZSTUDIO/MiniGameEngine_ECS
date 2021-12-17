return {
    new = function()
        local Class     = {
            depth       = "Depth",
            tileLayer   = "tilelayer",
            objectGroup = "objectgroup"
        }

        function Class:Get_Layer_By_Property(_pLayers, _pProperty)
            local layer
            local layers = {}
            for i = #_pLayers, 1, -1 do
                layer = _pLayers[i]
                if(layer.properties[_pProperty] ~= nil) then
                    table.insert(layers, layer)
                end
            end
            return layers
        end

        function Class:Get_Layer_By_Property_Ext(_pLayers, _pProperty, _pValue)
            local layer
            local layers = {}
            for i = #_pLayers, 1, -1 do
                layer = _pLayers[i]
                if(layer.properties[_pProperty] == _pValue) then
                    table.insert(layers, layer)
                end
            end
            return layers
        end
        
        function Class:Get_Layer_By_Type(_pLayers, _pType)
            local layer
            local layers = {}
            for i = #_pLayers, 1, -1 do
                layer = _pLayers[i]
                if(layer.type == _pType) then
                    table.insert(layers, layer)
                end
            end
            return layers
        end

        return Class
    end
}