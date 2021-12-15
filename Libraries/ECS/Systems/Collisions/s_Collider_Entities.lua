return {
  new = function()
    local system = p_System.new({"transform", "boxCollider"})
    
    local entities   = {}
    local deltaTime  = 0
    
    ----------
    -- Load --
    ----------
    function system:Load(_pEntity)
      if(debug) then print("Systems, loaded:      s_Collider_Entities by ".._pEntity.name) end
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
    
    return system
  end  
}