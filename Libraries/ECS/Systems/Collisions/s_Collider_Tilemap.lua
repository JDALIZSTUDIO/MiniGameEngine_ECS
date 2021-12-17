return {
    new = function()
      local system = p_System.new({"transform", "boxCollider", "rigidBody"})
      
      local layer      = {}
      local tileWidth  = 0
      local tileHeight = 0
      
      ----------
      -- Load --
      ----------
      function system:Load(_pEntity)
        if(isDebug) then print("Systems, loaded:      s_Collider_Tilemap by ".._pEntity.name) end
      end
      
      ---------------
      -- GetTileAt --
      ---------------
      function system:GetTileAt(_pX, _pY)
        local col    = math.floor(_pX / tileWidth ) + 1
        local lig    = math.floor(_pY / tileHeight) + 1
        local length = #layer.data
        
        if(col > 0 and col <= layer.width and lig > 0 and lig <= layer.height) then
          local index = ((lig-1) * layer.width) + col
          return layer.data[index]
        else
          return 0
        end
      end
            
      ------------------
      -- SetTileLayer --
      ------------------
      function system:SetTileLayer(_pTilemap)      
        layer      = _pTilemap:GetCollisions()
        tileWidth  = _pTilemap.map.tilewidth
        tileHeight = _pTilemap.map.tileheight
      end
      
      ------------
      -- Update --
      ------------
      function system:Update(dt, _pEntity)
        system:LayerCollisons(_pEntity)        
      end
      
      ----------------------
      -- TilemapCollisons --
      ----------------------
      function system:LayerCollisons(_pEntity)
        
        local length = #layer.data
        if(length < 1) then return end
        
        local transform = _pEntity:GetComponent("transform")
        local collider  = _pEntity:GetComponent("boxCollider")
        if(collider.active == false) then return end

        local posX, posY
        
        ----------------
        -- horizontal --
        ----------------      
        local collide = false
        if(transform.velocity.x > 0) then
          if(self:GetTileAt(collider.right, transform.position.y) ~= 0) then
            transform.velocity.x = 0
            transform.position.x = ((math.floor(transform.position.x / tileWidth) + 1) * tileWidth) - Round(collider.width*0.5) - 1
            collide = true
            
          end
          
        elseif(transform.velocity.x < 0) then
          if(self:GetTileAt(collider.left, transform.position.y) == tileID) then
            transform.velocityPre:Set(transform.velocity.x, transform.velocity.y)
            transform.velocity.x = 0
            transform.position.x = ((math.floor(transform.position.x / tileWidth) + 1) * tileWidth) - Round(collider.width*0.5)
            collide = true
            
          end          
        end
        
        ----------------
        -- vertical --
        ----------------
        if(transform.velocity.y > 0) then
          if(self:GetTileAt(transform.position.x, collider.bottom) ~= 0) then
            transform.velocityPre:Set(transform.velocity.x, transform.velocity.y)
            transform.velocity.y = 0
            transform.position.y = ((math.floor((transform.position.y+1) / tileHeight) + 1) * tileHeight) - Round(collider.height*0.5)
            collide = true
            
          end
          
        elseif(transform.velocity.y < 0) then
          if(self:GetTileAt(transform.position.x, collider.top) ~= 0) then
            transform.velocityPre:Set(transform.velocity.x, transform.velocity.y)
            transform.velocity.y = 0
            transform.position.y = (math.floor((transform.position.y-1) / tileHeight) * tileHeight) + Round(collider.height*0.5) - 1
            collide = true
            
          end          
        end
        
        if(collide) then
          local character = _pEntity:GetComponent("characterController")
          if(character ~= nil) then character:OnTileCollision(_pEntity, nil) end
          
        end        
      end
      
      return system
    end  
  }