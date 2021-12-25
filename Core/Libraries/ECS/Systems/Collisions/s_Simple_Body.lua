return {
    new = function()
      local system = p_System.new({"transform", "boundingBox", "simpleBody"})
            
      local bb         = "boundingBox"
      local ch         = "characterController"
      local sb         = "simpleBody"
      local tr         = "transform"

      local floor      = math.floor
      local insert     = table.insert
  
      local layer       = {}
      local layerWidth  = 0
      local layerHeight = 0
      local tileWidth   = 0
      local tileHeight  = 0      
      
      --------------------------------
      -- Collide_Tilemap_Horizontal --
      --------------------------------
      function system:Collide_Tilemap_Horizontal(dt, _pBBox, _pSolid, _pTransform)

        -- store velocity
        _pTransform.velocityPre:Set(_pTransform.velocity.x, _pTransform.velocityPre.y)

        local collide, ID, col
        local dX = _pTransform.velocity.x * dt

        -- RIGHT
        if(_pTransform.velocity.x > 0) then
          ID  = self:Get_Tile_At(_pBBox.right + dX + 1, _pBBox.position.y)
          col = floor(_pBBox.position.x / tileWidth) + 1
          if(ID ~= 0) then
            if(_pSolid) then
              _pTransform.velocity.x = 0
              _pTransform.position.x = (col * tileWidth) - floor(_pBBox.width*0.5) - 1
            end
            collide = true            
          end          
        
        -- LEFT
        elseif(_pTransform.velocity.x < 0) then
          ID = self:Get_Tile_At(_pBBox.left + dX -1, _pBBox.position.y)
          col = floor(_pBBox.position.x / tileWidth) + 1
          if(ID ~= 0) then
            if(_pSolid) then
              _pTransform.velocity.x = 0
              _pTransform.position.x = (col * tileWidth) - floor(_pBBox.width*0.5) + 1
            end
            collide = true            
          end
        end
        return collide
      end
      
      ------------------------------
      -- Collide_Tilemap_Vertical --
      ------------------------------
      function system:Collide_Tilemap_Vertical(dt, _pBBox, _pSolid, _pTransform)

        -- store velocity
        _pTransform.velocityPre:Set(_pTransform.velocityPre.x, _pTransform.velocity.y)

        local collide, ID, lig        
        local dY  = _pTransform.velocity.y * dt

        -- DOWN
        if(_pTransform.velocity.y > 0) then
          ID  = self:Get_Tile_At(_pBBox.position.x, _pBBox.bottom + dY + 1)
          lig = floor(_pBBox.position.y / tileHeight) + 1
          if(ID ~= 0) then
            if(_pSolid) then  
              _pTransform.velocity.y = 0
              _pTransform.position.y = (lig * tileHeight) - floor(_pBBox.height*0.5) - 1
            end
            collide                = true            
          end        
        
        -- UP        
        elseif(_pTransform.velocity.y < 0) then
          ID  = self:Get_Tile_At(_pBBox.position.x, _pBBox.top + dY - 1)
          lig = floor(_pBBox.position.y / tileHeight)
          if(ID ~= 0) then
            if(_pSolid) then
              _pTransform.velocity.y = 0
              _pTransform.position.y = (lig * tileHeight) + floor(_pBBox.height*0.5) + 1
            end
            collide                = true            
          end
        end
        return collide
      end
      
      ---------------
      -- GetTileAt --
      ---------------
      function system:Get_Tile_At(_pX, _pY)
        local col = floor(_pX / tileWidth ) + 1
        local lig = floor(_pY / tileHeight) + 1
        return layer.data[col][lig]
      end
        
      ----------
      -- Load --
      ----------
      function system:Load(_pEntity)
        if(isDebug) then print("Systems, loaded:      s_Entity_bBox by ".._pEntity.name) end
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
        local bBox       = _pEntity:Get_Component(bb)
        local simpleBody = _pEntity:Get_Component(sb)
        local transform  = _pEntity:Get_Component(tr)

        local length = layerWidth * layerHeight
        if(length < 1) then 
          local direction = simpleBody:_Get_Direction()
          local length    = simpleBody.velocity:Magnitude()
          local dx        = simpleBody:_Length_Dir_X(length, direction)
          local dy        = simpleBody:_Length_Dir_Y(length, direction)
          transform.position:Set(
            transform.position.x + (dx * dt),
            transform.position.y + (dy * dt)
          )
        else
          
          local collideX       = self:Collide_Tilemap_Horizontal(dt, bBox, simpleBody.isSolid, transform)
          local directionX     = simpleBody:_Get_Direction()
          local lengthX        = simpleBody._Get_Magnitude()
          local dx             = simpleBody:_Length_Dir_X(lengthX, directionX)
          transform.position.x = transform.position.x - (dx * dt)
          
          local collideY       = self:Collide_Tilemap_Vertical(dt, bBox, simpleBody.isSolid, transform)
          local directionY     = simpleBody:_Get_Direction()
          local lengthY        = simpleBody._Get_Magnitude()
          local dy             = simpleBody:_Length_Dir_Y(lengthY, directionY)
          transform.position.y = transform.position.y - (dy * dt)

          if(collideX or collideY) then
            local character = _pEntity:Get_Component(ch)
            if(character ~= nil) then character:On_Tile_Collision(nil) end            
          end  
        end
      end
      
      return system
    end  
  }