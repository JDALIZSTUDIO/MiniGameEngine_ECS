return {
  new = function(_pPath)
    local Tilemap = {
      debug       = true,
      image       = nil,
      quads       = nil,
      mapData     = nil,
      tileLayers  = {
        back      = {},
        front     = {},
        collisons = nil,
      },
      objects     = {},
      position    = {
        x = 0,
        y = 0
      }
    }
    
    ---------------
    -- GetTileAt --
    ---------------
    function Tilemap:GetTileAt(_pLayer, _pX, _pY)
      if(_pX > 0 and _pX <= #_pLayer.data and _pY > 0 and _pY <= #_pLayer.data) then
        local index = ((_pY-1) * _pLayer.width) + _pX
        return _pLayer.data[index]
      else
        return 0
      end
    end
    
    -------------
    -- LoadMap --
    -------------
    function Tilemap:LoadMap(_pPath)
      local colID     = _pColID or "collisions"
      self.mapData    = require(_pPath)
      
      local imagePath = self.mapData.tilesets[1].image:sub(3)
      self.image      = love.graphics.newImage("Libraries/Tilemap"..imagePath)
      
      self.quads = self:ReturnQuads(self.image)
      if(debug) then print("Tilemap, loaded:      "..tostring(#self.quads).." quads") end
      
      self:ParseLayers()
      if (debug) then print("Tilemap, loaded:      "..tostring(#self.tileLayers.back).." BackLayers") end
      if (debug) then print("Tilemap, loaded:      "..tostring(#self.tileLayers.front).." FrontLayers") end
      if (debug) then print("Tilemap, loaded:      "..tostring(#self.objects).." Objects") end
    end
    
    function Tilemap:ReturnQuads(_pImage)
      local quads = {}, quad
      local nbCol = math.floor(self.image:getWidth()  / self.mapData.tilewidth)
      local nbLig = math.floor(self.image:getHeight() / self.mapData.tileheight)
      for y = 1, nbLig, 1 do
        for x = 1, nbCol, 1 do
          quad = love.graphics.newQuad((x-1) * self.mapData.tilewidth,
                                       (y-1) * self.mapData.tileheight,
                                       self.mapData.tilewidth,
                                       self.mapData.tileheight,
                                       self.image:getDimensions());
          table.insert(quads, quad)
        end    
      end
      return quads
    end
    
    -----------------
    -- ParseLayers --
    -----------------
    function Tilemap:ParseLayers()
      local layer, depth
      for i = #self.mapData.layers, 1, -1 do
        layer = self.mapData.layers[i]
        
        -- sort tile layers
        if(layer.type == "tilelayer") then          
          
          -- sort by depth
          depth = layer.properties["Depth"]
          
          if(depth == nil or
             depth <= 0) then              
            table.insert(self.tileLayers.back, layer)      
            
          elseif(depth > 0) then
            table.insert(self.tileLayers.front, layer)
            
          end      
          
          -- store objects
        elseif(layer.type == "objectgroup") then
          for j = 1, #layer.objects, 1 do
            table.insert(self.objects, layer.objects[j])
            
          end      
        end
      end
    end    
    
    -------------------
    -- SetCollisions --
    -------------------
    function Tilemap:SetCollisions(_pColID)
      local layer
      for i = #_pLayers, 1, -1 do
        layer = _pLayers[i]
        if(layer.name == _pColID) then       
          return layer
        end    
      end
    end
    
    -----------------
    -- DrawLayers --
    -----------------
    function Tilemap:DrawLayers(_pLayers)
      if(self.quads == nil or #self.quads == 0) then return end
      
      local index, layer, x, y
      for i = #_pLayers, 1, -1 do
        layer = _pLayers[i]
        if(layer.visible == true) then       
          for yy = 1, layer.height, 1 do
            for xx = 1, layer.width, 1 do
              index = self:GetTileAt(layer, xx, yy)
              if(index > 0) then
                love.graphics.setColor(1, 1, 1, layer.opacity)
                love.graphics.draw(self.image, 
                                   self.quads[index], 
                                  (xx-1)*self.mapData.tilewidth, 
                                  (yy-1)*self.mapData.tileheight)
                
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
    function Tilemap:DrawBack()
      if(#self.tileLayers.back == 0) then return end
      self:DrawLayers(self.tileLayers.back)
    end
    
    ---------------
    -- DrawFront --
    ---------------
    function Tilemap:DrawFront()
      if(#self.tileLayers.front == 0) then return end
      self:DrawLayers(self.tileLayers.front)
    end
    
    return Tilemap
  end  
}