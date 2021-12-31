return {
    new = function() 
      local f_system       = Locator:Get_Service("f_system")
      local system         = f_system.new({"transform", "boundingBox", "rigidBody"})
            system.gravity = 0

      local floor  = math.floor
      local insert = table.insert
      local sign   = Sign
      
      local bb = "boundingBox"
      local rb = "rigidBody"
      local tr = "transform"

      local entities    = {}
      local layer       = {}
      local layerWidth  = 0
      local layerHeight = 0
      local tileWidth   = 0
      local tileHeight  = 0

      local deltaTime

      --------------------------------
      -- Collide_Tilemap_Horizontal --
      --------------------------------
      function system:Collide_Tilemap_Horizontal(dt, _pBBox, _pRigid, _pTransform)

        -- store velocity
        _pRigid.velocityPre:Set(_pRigid.velocity.x, _pRigid.velocityPre.y)

        local collide, ID, col
        local dX = _pRigid.velocity.x * dt

        -- RIGHT
        if(_pRigid.velocity.x > 0) then
          ID  = self:Get_Tile_At(_pBBox.right + dX + 1, _pBBox.position.y)
          col = floor(_pBBox.position.x / tileWidth) + 1
          if(ID ~= 0) then
            _pRigid.velocity.x     = 0
            _pTransform.position.x = (col * tileWidth) - floor(_pBBox.width*0.5) - 1
            collide = true            
          end          
        
        -- LEFT
        elseif(_pRigid.velocity.x < 0) then
          ID = self:Get_Tile_At(_pBBox.left + dX -1, _pBBox.position.y)
          col = floor(_pBBox.position.x / tileWidth) + 1
          if(ID ~= 0) then
            _pRigid.velocity.x = 0
            _pTransform.position.x = ((col-1) * tileWidth) + floor(_pBBox.width*0.5) + 1
            collide = true            
          end
        end
        return collide
      end
      
      ------------------------------
      -- Collide_Tilemap_Vertical --
      ------------------------------
      function system:Collide_Tilemap_Vertical(dt, _pBBox, _pRigid, _pTransform)

        -- store velocity
        _pRigid.velocityPre:Set(_pRigid.velocityPre.x, _pRigid.velocity.y)

        local collide, ID, lig        
        local dY  = _pRigid.velocity.y * dt

        -- DOWN
        if(_pRigid.velocity.y > 0) then
          ID  = self:Get_Tile_At(_pBBox.position.x, _pBBox.bottom + dY + 1)
          lig = floor(_pBBox.position.y / tileHeight) + 1
          if(ID ~= 0) then       
            _pRigid.velocity.y     = 0
            _pTransform.position.y = (lig * tileHeight) - floor(_pBBox.height*0.5) - 1
            collide                = true            
          end        
        
        -- UP        
        elseif(_pRigid.velocity.y < 0) then
          ID  = self:Get_Tile_At(_pBBox.position.x, _pBBox.top + dY - 1)
          lig = floor(_pBBox.position.y / tileHeight)
          if(ID ~= 0) then
            _pRigid.velocity.y     = 0
            _pTransform.position.y = (lig * tileHeight) + floor(_pBBox.height*0.5) + 1
            collide                = true            
          end
        end
        return collide
      end

      ----------------------
      -- Collide_Entities --
      ----------------------
      function system:Collide_Entities(_pEntity)        
        local length = #entities
        if(length < 2) then return end
  
        local bBox  = _pEntity:Get_Component(bb)
        local otherBBox, otherRigid
        
        for i = length, 1, -1 do
          other = entities[i]      
          if(other ~= _pEntity      and 
             other.expired == false and
             other.active  == true) then              
            otherRigid = other:Get_Component(rb)
            if(system:Match(other) and 
               otherRigid.active == true) then
              otherBBox = other:Get_Component(bb)
              if(bBox:Intersects(otherBBox)) then
                self:Resolve_Collision(_pEntity, other)
              end
            end
          end
        end     
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
        local rigidBody = _pEntity:Get_Component(rb)
              rigidBody:Load()
        
        entities = self.ECS:Get_Entities()

        if(isDebug) then print("Systems, loaded:      s_Rigid_Body by ".._pEntity.name) end
      end    

      -----------------------
      -- Resolve_Collision --
      ----------------------- 
      function system:Resolve_Collision(_pEntity, _pOther)        
        local transformA = _pEntity:Get_Component("transform")
        local transformB = _pOther:Get_Component("transform")   
        local bBoxA      = _pEntity:Get_Component(bb)
        local bBoxB      = _pOther:Get_Component(bb)
        local rigidA     = _pEntity:Get_Component(rb)
        local rigidB     = _pOther:Get_Component(rb)

        local dX  = bBoxA.position.x - bBoxB.position.x
        local dY  = bBoxA.position.y - bBoxB.position.y
        local aDX = math.abs(dX)
        local aDY = math.abs(dY)
        local sHW = (bBoxA.width  * 0.5) + (bBoxB.width * 0.5)
        local sHH = (bBoxA.height * 0.5) + (bBoxB.height * 0.5)
        
        if(aDX < sHW or aDY < sHH) then
          local sX = sHW - aDX
          local sY = sHH - aDY
          
          if(sX < sY) then
            if(sX > 0) then
              sY = 0
            end
          else
            if(sY > 0) then
              sX = 0            
            end          
          end
          
          if(dX < 0) then
            sX = -sX          
          end        
          if(dY < 0) then
            sY = -sY
          end
               
          local distance   = math.sqrt(sX * sX + sY * sY)
          local dtVXA      = rigidA.velocity.x
          local dtVYA      = rigidA.velocity.y
          local dtVXB      = rigidB.velocity.x
          local dtVYB      = rigidB.velocity.y
          local nX, nY     = sX / distance, sY / distance
          local vX, vY     = dtVXA - (dtVXB or 0), dtVXB - (dtVXB or 0)        
          local pS         = vX * nX + vY * nY
          
          if(pS <= 0) then
            if(rigidA.isBounce) then
              if(sX ~= 0) then rigidA.velocity.x = -rigidA.velocity.x*0.9 end
              if(sY ~= 0) then rigidA.velocity.y = -rigidA.velocity.y*0.9 end
            else
              if(sX ~= 0) then rigidA.velocity.x = 0 end
              if(sY ~= 0) then rigidA.velocity.y = 0 end
            end
            transformA.position.x = transformA.position.x + sX
            transformA.position.y = transformA.position.y + sY
          end      
        end      
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
        deltaTime       = dt
        local bBox      = _pEntity:Get_Component(bb)
        local rigidBody = _pEntity:Get_Component(rb)
        local transform = _pEntity:Get_Component(tr)
        
        if(rigidBody.active == false) then return end

        rigidBody:_Apply_Gravity(self.gravity)        
        rigidBody:_Clamp_Velocity()

        local length = layerWidth * layerHeight
        if(length < 1) then 
          local direction = rigidBody:_Get_Direction()
          local length    = rigidBody._Get_Magnitude()
          local dx        = rigidBody:_Length_Dir_X(length, direction)
          local dy        = rigidBody:_Length_Dir_Y(length, direction)
          transform.position:Set(
            transform.position.x + (dx * dt),
            transform.position.y + (dy * dt)
          )
        else          
          local collideX       = self:Collide_Tilemap_Horizontal(dt, bBox, rigidBody, transform)
          local directionX     = rigidBody:_Get_Direction()
          local lengthX        = rigidBody._Get_Magnitude()
          local dx             = rigidBody:_Length_Dir_X(lengthX, directionX)

          transform.position.x = transform.position.x - (dx * dt)
          
          local collideY       = self:Collide_Tilemap_Vertical(dt, bBox, rigidBody, transform)
          local directionY     = rigidBody:_Get_Direction()
          local lengthY        = rigidBody._Get_Magnitude()
          local dy             = rigidBody:_Length_Dir_Y(lengthY, directionY)

          transform.position.y = transform.position.y - (dy * dt)          

          if(rigidBody.isStatic == false) then
            self:Collide_Entities(_pEntity)
          end

          if(collideX or collideY) then
            local character = _pEntity:Get_Component(ch)
            if(character ~= nil) then character:On_Collision_With_Tilemap(nil) end            
          end  
        end
        rigidBody:_Apply_Friction()
      end

      ----------
      -- Draw --
      ----------
      function system:Draw(_pEntity)
      end
      
      return system 
    end
  }