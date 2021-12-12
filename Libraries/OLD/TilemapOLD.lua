local tm          = {
      debug       = true,
      collisions  = nil,
      map         = nil,
      image       = nil,
      quads       = nil,
      tileLayers  = {
        back  = {},
        front = {},
      },
      objects     = {},
}

function tm:GetCollisions(_pString)
  return tm.collisions
end

function tm:GetTileAt(_pLayer, _pX, _pY)
  if(_pX > 0 and _pX <= #_pLayer.data and _pY > 0 and _pY <= #_pLayer.data) then
    local index = ((_pY-1) * _pLayer.width) + _pX
    return _pLayer.data[index]
  else
    return 0
  end
end

function tm:LoadMap(_pPath, _pColID)
  local colID = _pColID or "collisions"
  tm.map = require(_pPath)
  
  local imagePath = tm.map.tilesets[1].image:sub(3)
  tm.image = love.graphics.newImage("Libraries/Tilemap"..imagePath)
  
  tm.quads = tm:ReturnQuads(tm.image)
  if(debug) then print("Tilemap, loaded:      "..tostring(#tm.quads).." quads") end
  
  tm:ParseLayers(colID)
  if (debug) then print("Tilemap, loaded:      "..tostring(#tm.tileLayers.back).." BackLayers") end
  if (debug) then print("Tilemap, loaded:      "..tostring(#tm.tileLayers.front).." FrontLayers") end
  if (debug) then print("Tilemap, loaded:      "..tostring(#tm.objects).." Objects") end
end

function tm:ReturnQuads(_pImage)
  local quads = {}, quad
  local nbCol = math.floor(tm.image:getWidth()  / tm.map.tilewidth)
  local nbLig = math.floor(tm.image:getHeight() / tm.map.tileheight)
  for y = 1, nbLig, 1 do
    for x = 1, nbCol, 1 do
      quad = love.graphics.newQuad((x-1) * tm.map.tilewidth,
                                   (y-1) * tm.map.tileheight,
                                   tm.map.tilewidth,
                                   tm.map.tileheight,
                                   tm.image:getDimensions());
      table.insert(quads, quad)
    end    
  end
  return quads
end

function tm:ParseLayers(_pColID)
  local layer, depth
  for i = 1, #tm.map.layers, 1 do
    layer = tm.map.layers[i]
    
    -- sort tile layers
    if(layer.type == "tilelayer") then
      
      -- get collisons
      if(layer.name == _pColID) then tm.collisions = layer end
      
      -- sort by depth
      depth = layer.properties["Depth"]
      if(depth == nil or depth <= 0) then 
        table.insert(tm.tileLayers.back, layer)      
        
      elseif(depth > 0) then
        table.insert(tm.tileLayers.front, layer)
        
      end      
      
    elseif(layer.type == "objectgroup") then
      
      -- store objects
      for j = 1, #layer.objects, 1 do
        table.insert(tm.objects, layer.objects[j])
        
      end      
    end
  end
end

function tm:DrawLayers(_pLayers)
  if(tm.quads == nil or #tm.quads == 0) then return end
  
  local index, layer, x, y
  for i = #_pLayers, 1, -1 do
    layer = _pLayers[i]
    if(layer.visible == true) then       
      for yy = 1, layer.height, 1 do
        for xx = 1, layer.width, 1 do
          index = tm:GetTileAt(layer, xx, yy)
          if(index > 0) then
            love.graphics.draw(tm.image, 
                               tm.quads[index], 
                              (xx-1)*tm.map.tilewidth, 
                              (yy-1)*tm.map.tileheight)
            
          end
        end
      end 
    end    
  end
end

function tm:DrawBack()
  if(#tm.tileLayers.back == 0) then return end
  tm:DrawLayers(tm.tileLayers.back)
end

function tm:DrawFront()
  if(#tm.tileLayers.front == 0) then return end
  tm:DrawLayers(tm.tileLayers.front)
end

return tm