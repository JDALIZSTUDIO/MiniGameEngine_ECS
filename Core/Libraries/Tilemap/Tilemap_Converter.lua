return {
    new = function()
        local Class = {}
        
        local insert = table.insert

        --------------------
        -- Layers1D_To_2D --
        --------------------
        function Class:Layers1D_To_2D(_pLayers)
            if(#_pLayers == 0) then return {} end
            local layer
            local layers = {}
            for i = 1, #_pLayers do
                layer = _pLayers[i]
                layer.data = self:Layer1D_To_Layer2D(layer)
                insert(layers, layer)
            end
            return layers
        end

        ------------------------
        -- Layer1D_To_Layer2D --
        ------------------------
        function Class:Layer1D_To_Layer2D(_pLayer)
            return Table:Clone1D_To_2D(_pLayer.data, _pLayer.width, _pLayer.height)
        end

        return Class
    end
}