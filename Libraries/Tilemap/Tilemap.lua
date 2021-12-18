return {
    new = function()
        local Class        = {
            animations     = {},
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

        function Class:Load(_pPath)
            ----------------
            -- Load_Stuff --
            ----------------
            animator  = require('Libraries/Tilemap/Tilemap_Animator').new()
            converter = require('Libraries/Tilemap/Tilemap_Converter').new()
            extractor = require('Libraries/Tilemap/Tilemap_Tiles').new()
            parser    = require('Libraries/Tilemap/Tilemap_Parser').new()

            self.map  = require(_pPath)

            local imagePath = self.map.tilesets[1].image:sub(3)
            self.image      = love.graphics.newImage("Libraries/Tilemap"..imagePath)

            self.quads      = extractor:Return_Quads(self.image, self.map.tilewidth, self.map.tileheight)
            if(isDebug) then print("Tilemap, loaded:      "..tostring(#self.quads).." quads") end
            
            self.animations = extractor:Return_Animations(self.map.tilesets[1])
            -----------
            -- Parse --
            -----------
            local tileLayers = parser:Get_Layer_By_Type(self.map.layers, parser.tileLayer)
            local backlayers  = parser:Get_Layer_By_Property_Ext(tileLayers, "Depth", 0)
            if(#backlayers == 0) then
                self.tileLayers.back = tileLayers
            else
                self.tileLayers.back = backlayers
                self.tileLayers.front = parser:Get_Layer_By_Property_Ext(tileLayers, "Depth", 1)
            end
            self.tileLayers.collisions = parser:Get_Layer_By_Property_Ext(tileLayers, "Solid", true)

            -------------
            -- Convert --
            -------------
            self.tileLayers.back       = converter:Layers1D_To_2D(self.tileLayers.back)
            self.tileLayers.front      = converter:Layers1D_To_2D(self.tileLayers.front)
            self.tileLayers.collisions = converter:Layers1D_To_2D(self.tileLayers.collisions)
        end

        function Class:Update(dt)
            animator:Animate(dt, self.animations)
        end

        -----------------
        -- DrawLayers --
        -----------------
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
                                love.graphics.draw(self.image, 
                                                   quad,
                                                   (xx-1)*self.map.tilewidth, 
                                                   (yy-1)*self.map.tileheight)
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