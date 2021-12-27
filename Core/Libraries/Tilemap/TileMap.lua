return {
    new = function()
        local Class        = {
            animations     = {},
            collisions     = {},
            image          = nil,
            quads          = nil,
            map            = nil,
            tileLayers     = {
                back       = {},
                front      = {},
                collisions = {},
            },
            objects        = {},
            position       = {
                x = 0,
                y = 0
            }
        }

        local animator, converter, extractor, parser

        --------------------
        -- Get_Collisions --
        --------------------
        function Class:Get_Collisions()        
            return self.collisions[1]
        end

        -----------------
        -- Get_Objects --
        -----------------
        function Class:Get_Objects()        
            return self.objects[1].objects
        end

        ----------
        -- Load --
        ----------
        function Class:Load(_pPath, _pImagePrefix)

            ----------------
            -- Load_Stuff --
            ----------------
            animator  = require('Core/Libraries/Tilemap/Tilemap_Animator').new()
            converter = require('Core/Libraries/Tilemap/Tilemap_Converter').new()
            extractor = require('Core/Libraries/Tilemap/Tilemap_Tiles').new()
            parser    = require('Core/Libraries/Tilemap/Tilemap_Parser').new()
            
            --------------
            -- Load_Map --
            --------------
            self.map  = require(_pPath)

            ----------------
            -- Load Image --
            ----------------
            --local imagePath = self.map.tilesets[1].image:sub(3)
            local imagePath = self.map.tilesets[1].image
            self.image      = love.graphics.newImage(_pImagePrefix..imagePath)            
            
            ------------------------------
            -- Extract Quads/Animations --
            ------------------------------
            self.quads      = extractor:Return_Quads(self.image, self.map.tilewidth, self.map.tileheight)            
            self.animations = extractor:Return_Animations(self.map.tilesets[1])

            if(isDebug) then print("Tilemap, loaded image: "..imagePath) end
            if(isDebug) then print("Tilemap, loaded quads: "..tostring(#self.quads)) end

            -----------
            -- Parse --
            -----------
            local tileLayers  = parser:Get_Layers_By_Type(self.map.layers, parser.name.tileLayer)
            local backlayers  = parser:Get_Layers_By_Property_Ext(tileLayers, parser.property.depth, 0)
            if(#backlayers == 0) then
                self.tileLayers.back   = tileLayers
            else
                self.tileLayers.back   = backlayers
                self.tileLayers.front  = parser:Get_Layers_By_Property_Ext(tileLayers, parser.property.depth, 1)
            end
            self.objects               = parser:Get_Layers_By_Type(self.map.layers, parser.name.objectGroup)
            
            if(isDebug) then print("Tilemap, extracted layers  : "..tostring(#self.tileLayers.back).." Back") end
            if(isDebug) then print("Tilemap, extracted layers  : "..tostring(#self.tileLayers.front).." Front") end
            if(isDebug) then print("Tilemap, extracted objects : "..tostring(#self.objects)) end

            -------------
            -- Convert --
            -------------
            self.tileLayers.back       = converter:Layers1D_To_2D(self.tileLayers.back)
            self.tileLayers.front      = converter:Layers1D_To_2D(self.tileLayers.front)
            
            if(isDebug) then print("Tilemap, converted         : "..tostring(#self.tileLayers.back).." Back Layers, 1D to 2D tables") end
            if(isDebug) then print("Tilemap, converted         : "..tostring(#self.tileLayers.front).." Front Layers, 1D to 2D tables") end
            
            self.collisions            = parser:Get_Layers_By_Property_Ext(tileLayers, parser.property.solid, true)
            if(isDebug) then print("Tilemap, extracted layers  : "..tostring(#self.collisions).." Collision") end
        end

        ------------
        -- Update --
        ------------
        function Class:Update(dt)
            animator:Animate(dt, self.animations)
        end

        ----------------
        -- DrawLayers --
        ----------------
        function Class:DrawLayers(_pLayers)
            if(self.quads == nil or #self.quads == 0) then return end
            
            local anim, id, layer, quad, tile
            for i = #_pLayers, 1, -1 do
                layer = _pLayers[i]
                if(layer.visible == true) then       
                    for yy = 1, layer.height do
                        for xx = 1, layer.width do
                            tile = layer.data[xx][yy]                     
                            anim = self.animations[tile-1]

                            id = tile
                            if(anim ~= nil) then
                                id = anim.currentFrame.tileid
                            end
                            
                            quad = self.quads[id]
                            if(quad ~= nil) then
                                love.graphics.setColor(1, 1, 1, layer.opacity)
                                love.graphics.draw(
                                    self.image, 
                                    quad,
                                    (xx-1)*self.map.tilewidth, 
                                    (yy-1)*self.map.tileheight
                                )
                            end
                        end
                    end 
                end    
            end            
            love.graphics.setColor(1, 1, 1, 1)
        end
        
        --------------
        -- DrawBack --
        --------------
        function Class:DrawBack()
            if(#self.tileLayers.back == 0) then return end
            self:DrawLayers(self.tileLayers.back)
        end
        
        ---------------
        -- DrawFront --
        ---------------
        function Class:DrawFront()
            if(#self.tileLayers.front == 0) then return end
            self:DrawLayers(self.tileLayers.front)
        end        

        return Class
    end
}