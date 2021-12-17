return {
    new = function()
        local Class = {}
        
        function Class:New_Tile()
            local tile = {
                animation,
                index,
                position,
                quad
            }
            return tile
        end

        function Class:Return_Tiles(_pImage, _pTileW, _pTileH)
            local index, tile            
            local nbCol = math.floor(_pImage:getWidth()  / _pTileW)
            local nbLig = math.floor(_pImage:getHeight() / _pTileH)
            local tiles = Table:New_Table_2D(nbCol, nbLig)
            
            for yy = 1, nbLig do
                for xx = 1, nbCol do
                    tile = self:New_Tile()
                end    
            end
            return tiles
        end

        function Class:Return_Quads(_pImage, _pTileW, _pTileH)
            local quads = {}, quad
            local nbCol = math.floor(_pImage:getWidth()  / _pTileW)
            local nbLig = math.floor(_pImage:getHeight() / _pTileH)
            for y = 1, nbLig, 1 do
                for x = 1, nbCol, 1 do
                    quad = love.graphics.newQuad((x-1) * _pTileW,
                                                 (y-1) * _pTileH,
                                                 _pTileW,
                                                 _pTileH,
                                                 _pImage:getDimensions());
                    table.insert(quads, quad)
                end    
            end
            return quads
        end

        return Class
    end
}