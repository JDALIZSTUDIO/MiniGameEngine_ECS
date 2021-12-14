return {
  new = function()
    local system = p_System.new({"transform", "boxCollider"})
    
    local entities   = {}
    local layer      = {}
    local tileWidth  = 0
    local tileHeight = 0
    local deltaTime  = 0
    
    ----------
    -- Load --
    ----------
    function system:Load(_pEntity)
      if(debug) then print("Systems, loaded:      s_Collider by ".._pEntity.name) end
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
    
    ----------------
    -- Intersects --
    ----------------
    function system:Intersects(_pEntity, _pOther)
      local bb    = "boxCollider"
      local bBoxA = _pEntity:GetComponent(bb)
      local bBoxB = _pOther:GetComponent(bb)
      
      if(bBoxB == nil) then return false end
      
      local dX  = bBoxA.position.x - bBoxB.position.x
      local dY  = bBoxA.position.y - bBoxB.position.y
      local aDX = math.abs(dX)
      local aDY = math.abs(dY)      
      local sHW = (bBoxA.width*0.5)  + (bBoxB.width*0.5)
      local sHH = (bBoxA.height*0.5) + (bBoxB.height*0.5)
      
      if(aDX >= sHW or aDY >= sHH) then
        return false
        
      else        
        
        if(bBoxA.isTrigger   or 
           bBoxA.isKinematic or
           bBoxB.isTrigger   or
           bBoxB.isKinematic) then return true end
        
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
        
        local transformA = _pEntity:GetComponent("transform")
        local transformB = _pOther:GetComponent("transform")        
        local distance   = math.sqrt(sX * sX + sY * sY)
        local nX , nY    = sX / distance, sY / distance        
        local dtVXA      = transformA.velocity.x * deltaTime
        local dtVYA      = transformA.velocity.y * deltaTime        
        local dtVXB      = transformB.velocity.x * deltaTime
        local dtVYB      = transformB.velocity.y * deltaTime        
        local vX, vY     = dtVXA - (dtVXB or 0), dtVXB - (dtVXB or 0)        
        local pS         = vX * nX + vY * nY
        
        if(pS <= 0) then
          
          transformA.position.x = transformA.position.x + sX
          transformA.position.y = transformA.position.y + sY
          
          local reflector = _pEntity:GetComponent("entityReflector")
          if(reflector ~= nil) then 
            reflector:Reflect(_pOther)
          else
            if(sX ~= 0) then 
              transformA.velocity:Set(0, transformA.velocity.y)
            end
            if(sY ~= 0) then 
              transformA.velocity:Set(transformA.velocity.x, 0)
            end
          end
        end
        
        return true        
      end
      
    end
    
    -----------------
    -- SetEntities --
    -----------------
    function system:SetEntities(_pEntities)
      entities = _pEntities
    end
    
    ------------------
    -- SetTileLayer --
    ------------------
    function system:SetTileLayer(_pTilemap)      
      layer      = _pTilemap:GetCollisions()
      tileWidth  = _pTilemap.mapData.tilewidth
      tileHeight = _pTilemap.mapData.tileheight
    end
    
    ------------
    -- Update --
    ------------
    function system:Update(dt, _pEntity)
      local transform = _pEntity:GetComponent("transform")
      local collider  = _pEntity:GetComponent("boxCollider")
      if(collider.active == false) then return end
      
      deltaTime = dt
      system:UpdateBoxCollider(transform, collider)
      system:EntityCollisions(_pEntity)
      system:LayerCollisons(_pEntity)
      
    end
    
    ------------------------
    -- UpdateBoxCollider --
    ------------------------
    function system:UpdateBoxCollider(_pTransform, _pCollider) 
      _pCollider.position.x = Round(_pTransform.position.x + _pCollider.offset.x)
      _pCollider.position.y = Round(_pTransform.position.y + _pCollider.offset.y)
      _pCollider.top        = Round(_pCollider.position.y - ((_pCollider.height * 0.5) * _pTransform.scale.y))
      _pCollider.bottom     = Round(_pCollider.position.y + ((_pCollider.height * 0.5) * _pTransform.scale.y))
      _pCollider.left       = Round(_pCollider.position.x - ((_pCollider.width  * 0.5) * _pTransform.scale.x))
      _pCollider.right      = Round(_pCollider.position.x + ((_pCollider.width  * 0.5) * _pTransform.scale.x))
    end
    
    ----------------------
    -- EntityCollisions --
    ----------------------
    function system:EntityCollisions(_pEntity)
      local length = #entities
      if(length < 2) then print("no_entities_to_collide_with") return end
      
      local result = {}
      
      for i = length, 1, -1 do
        other = entities[i]        
        if(other ~= _pEntity      and 
           other.expired == false and
           other.active  == true) then
           
          if(system:Match(other)) then
            if(system:Intersects(_pEntity, other)) then 
                table.insert(result, other)
            end
          end
        end
      end 
      
      local character = _pEntity:GetComponent("characterController")
      if(character ~= nil) then character:OnEntityCollision(result) end
      
    end
    
    ----------------------
    -- TilemapCollisons --
    ----------------------
    function system:LayerCollisons(_pEntity)
      
      local length = #layer.data
      if(length < 1) then return end
      
      local transform = _pEntity:GetComponent("transform")
      local bBox      = _pEntity:GetComponent("boxCollider")
      
      local posX, posY
      
      ----------------
      -- horizontal --
      ----------------      
      local collide = false
      if(transform.velocity.x > 0) then
        if(self:GetTileAt(bBox.right, transform.position.y) ~= 0) then
          transform.velocity.x = 0
          transform.position.x = ((math.floor(transform.position.x / tileWidth) + 1) * tileWidth) - Round(bBox.width*0.5) - 1
          collide = true
          
        end
        
      elseif(transform.velocity.x < 0) then
        if(self:GetTileAt(bBox.left, transform.position.y) == tileID) then
          transform.velocityPre:Set(transform.velocity.x, transform.velocity.y)
          transform.velocity.x = 0
          transform.position.x = ((math.floor(transform.position.x / tileWidth) + 1) * tileWidth) - Round(bBox.width*0.5)
          collide = true
          
        end
        
      end
      
      ----------------
      -- vertical --
      ----------------
      if(transform.velocity.y > 0) then
        if(self:GetTileAt(transform.position.x, bBox.bottom) ~= 0) then
          transform.velocityPre:Set(transform.velocity.x, transform.velocity.y)
          transform.velocity.y = 0
          transform.position.y = ((math.floor((transform.position.y+1) / tileHeight) + 1) * tileHeight) - Round(bBox.height*0.5)
          collide = true
          
        end
        
      elseif(transform.velocity.y < 0) then
        if(self:GetTileAt(transform.position.x, bBox.top) ~= 0) then
          transform.velocityPre:Set(transform.velocity.x, transform.velocity.y)
          transform.velocity.y = 0
          transform.position.y = (math.floor((transform.position.y-1) / tileHeight) * tileHeight) + Round(bBox.height*0.5) - 1
          collide = true
          
        end
        
      end
      
      if(collide) then
        local charC = _pEntity:GetComponent("characterController")
              charC:OnTileCollision(_pEntity, nil)
        
      end
      
    end
    
    return system
  end  
}