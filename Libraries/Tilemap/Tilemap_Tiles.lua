return {
    new = function()
        local Class = {}

        function Class:Return_Animations(_pTileset)
            local tile, anim
            local animations = {}
            local tiles = _pTileset.tiles
            for i = 1, #tiles do
                tile             = tiles[i]
                for j = 1, #tile.animation do
                    tile.animation[j].tileid = tile.animation[j].tileid+1
                end

                anim             = {
                    currentFrame = tile.animation[1],
                    frameCounter = 0,
                    frames       = tile.animation,
                    indexFrame   = 1
                }
                animations[tile.id] = anim
                if(isDebug) then print("Tileset: ".._pTileset.name..", Added tile animation index: "..tostring(tile.id)) end
            end            
            return animations
        end
        
        function Class:Return_Quads(_pImage, _pTileW, _pTileH)
            local quads = {}, quad
            local nbCol = math.floor(_pImage:getWidth()  / _pTileW)
            local nbLig = math.floor(_pImage:getHeight() / _pTileH)
            for y = 1, nbLig do
                for x = 1, nbCol do
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