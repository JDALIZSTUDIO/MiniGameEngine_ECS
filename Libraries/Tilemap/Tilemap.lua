return {
    new = function()
        local Class = {
            image          = nil,
            quads          = nil,
            map        = nil,
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

        local converter, extractor, parser

        function Class:Load(_pPath)
            ----------------
            -- Load_Stuff --
            ----------------
            converter = require('Libraries/Tilemap/Tilemap_2D_Converter').new()
            extractor = require('Libraries/Tilemap/Tilemap_Quads_Extractor').new()
            parser    = require('Libraries/Tilemap/Tilemap_Parser').new()

            self.map  = require(_pPath)

            local imagePath = self.map.tilesets[1].image:sub(3)
            self.image      = love.graphics.newImage("Libraries/Tilemap"..imagePath)

            self.quads      = extractor:Return_Quads(self.image, self.map.tilewidth, self.map.tileheight)
            if(isDebug) then print("Tilemap, loaded:      "..tostring(#self.quads).." quads") end
            
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

            --print(#self.tileLayers.collisions)
            -------------
            -- Convert --
            -------------
            self.tileLayers.back       = converter:Layers1D_To_2D(self.tileLayers.back)
            self.tileLayers.front      = converter:Layers1D_To_2D(self.tileLayers.front)
            self.tileLayers.collisions = converter:Layers1D_To_2D(self.tileLayers.collisions)
        end

        function Class:Update(dt)

        end

        -----------------
        -- DrawLayers --
        -----------------
        function Class:DrawLayers(_pLayers)
            if(self.quads == nil or #self.quads == 0) then return end
            
            local index, layer, x, y, quad
            for i = #_pLayers, 1, -1 do
                layer = _pLayers[i]
                if(layer.visible == true) then       
                    for yy = 1, layer.height do
                        for xx = 1, layer.width do
                            index = layer.data[xx][yy]
                            quad  = self.quads[index]
                            if(isDebug) then                                
                                --print("index: "..tostring(index)..", xx: "..tostring(xx)..", yy: "..tostring(yy))
                            end
                            if(quad ~= nil) then
                                love.graphics.setColor(1, 1, 1, layer.opacity)
                                love.graphics.draw(self.image, 
                                                   self.quads[index],
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