return {
    new = function()
      local system = p_System.new({"transform", "boundingBox"})
      
      local layer       = {}
      local layerWidth  = 0
      local layerHeight = 0
      local tileWidth   = 0
      local tileHeight  = 0
      local vDtX, vDtY

      local bc = "boundingBox"
      local ch = "characterController"
      local rb = "rigidBody"
      local tr = "transform"

      ----------
      -- Load --
      ----------
      function system:Load(_pEntity)
        if(isDebug) then print("Systems, loaded:      s_Tilemap_Collider by ".._pEntity.name) end
      end
      
      ---------------
      -- GetTileAt --
      ---------------
      function system:Get_Tile_At(_pX, _pY)
        local col = math.floor(_pX / tileWidth ) + 1
        local lig = math.floor(_pY / tileHeight) + 1
        return layer[col][lig]
      end
            
      ------------------
      -- SetTileLayer --
      ------------------
      function system:Set_Tilemap(_pTilemap)      
        layer       = _pTilemap:Get_Collisions()
        layerWidth  = _pTilemap.map.width
        layerHeight = _pTilemap.map.height
        tileWidth   = _pTilemap.map.tilewidth
        tileHeight  = _pTilemap.map.tileheight
      end
      
      ------------
      -- Update --
      ------------
      function system:Update(dt, _pEntity)
        local transform = _pEntity:GetComponent(tr)
        vDtX = transform.velocity.x * dt
        vDtY = transform.velocity.y * dt

        system:LayerCollisons(_pEntity)        
      end
      
      ----------------------
      -- TilemapCollisons --
      ----------------------
      function system:LayerCollisons(_pEntity)
        
        local length = layerWidth * layerHeight
        if(length < 1) then return end
        
        local transform = _pEntity:GetComponent(tr)
        local collider  = _pEntity:GetComponent(bc)
        if(collider.active == false) then return end

        local ID, posX, posY
        
        ----------------
        -- horizontal --
        ----------------      
        local collideX = false
        if(transform.velocity.x > 0) then
          ID = self:Get_Tile_At(collider.right, collider.position.y)
          if(ID ~= 0) then
            transform.velocity.x = 0
            transform.position.x = ((math.floor(collider.position.x / tileWidth) + 1) * tileWidth) - Round(collider.width*0.5) - 1
            collideX = true
            
          end
          
        elseif(transform.velocity.x < 0) then
          ID = self:Get_Tile_At(collider.left, collider.position.y)
          if(ID == tileID) then
            transform.velocityPre:Set(transform.velocity.x, transform.velocity.y)
            transform.velocity.x = 0
            transform.position.x = ((math.floor(collider.position.x / tileWidth) + 1) * tileWidth) - Round(collider.width*0.5)
            collideX = true
            
          end          
        end

        ----------------
        -- vertical --
        ----------------
        local collideY
        if(transform.velocity.y > 0) then
          ID = self:Get_Tile_At(collider.position.x, collider.bottom)
          if(ID ~= 0) then
            transform.velocityPre:Set(transform.velocity.x, transform.velocity.y)
            transform.velocity.y = 0
            transform.position.y = ((math.floor((collider.position.y+1) / tileHeight) + 1) * tileHeight) - Round(collider.height*0.5)
            collideY = true
            
          end
          
        elseif(transform.velocity.y < 0) then
          ID = self:Get_Tile_At(collider.position.x, collider.top)
          if(ID ~= 0) then
            transform.velocityPre:Set(transform.velocity.x, transform.velocity.y)
            transform.velocity.y = 0
            transform.position.y = (math.floor((collider.position.y-1) / tileHeight) * tileHeight) + Round(collider.height*0.5) - 1
            collideY = true
            
          end          
        end
        
        if(collideX or collideY) then
          local character = _pEntity:GetComponent(ch)
          if(character ~= nil) then character:OnTileCollision(ID) end
          
        end        
      end
      
      return system
    end  
  }