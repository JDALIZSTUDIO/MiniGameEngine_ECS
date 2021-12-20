return {
  new = function(_pOffsetX, _pOffsetY, _pWidth, _pHeight)
    local bBox = p_Component.new("boundingBox")
          bBox.drawMode  = 'line'
          bBox.isStatic  = false
          bBox.isTrigger = true
          bBox.top       = 0
          bBox.bottom    = 0
          bBox.left      = 0
          bBox.right     = 0
          bBox.width     = _pWidth or 0
          bBox.height    = _pHeight or 0
          bBox.offset    = Vector2.new(_pOffsetX or 0, _pOffsetY or 0)
          bBox.position  = Vector2.new(0, 0)
    
    local gameObject = nil

    local round = Round

    function bBox:Load()
      gameObject = self.gameObject
    end

    ----------------
    -- Intersects --
    ----------------
    function bBox:Intersects(_pOther)
      local bb    = "boundingBox"
      local bBoxA = gameObject:GetComponent(bb)
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
           bBoxA.isStatic or
           bBoxB.isTrigger   or
           bBoxB.isStatic) then return true end
        
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
        
        local transformA = gameObject:GetComponent("transform")
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
          
          if(isStatic == false) then
            self:Reflect(_pOther)
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

    -------------
    -- Reflect --
    -------------
    function bBox:Reflect(_pOther)
      local transform = gameObject:GetComponent("transform")
      local bBoxA     = gameObject:GetComponent("boundingBox")
      local bBoxB     = _pOther:GetComponent("boundingBox")
      
      if(bBoxA.position.y < bBoxB.top) then 
        transform.velocity.y = -transform.velocity.y 
        
      elseif(bBoxA.position.y > bBoxB.bottom) then 
        transform.velocity.y = -transform.velocity.y 
        
      else         
        transform.velocity.x = -transform.velocity.x
        
      end
    end
    
    ---------------------
    -- Update_Collider --
    ---------------------
    function bBox:Update_Collider(_pTransform) 
      self.position.x = round(_pTransform.position.x + self.offset.x)
      self.position.y = round(_pTransform.position.y + self.offset.y)
      self.top        = round(self.position.y - ((self.height * 0.5) * _pTransform.scale.y))
      self.bottom     = round(self.position.y + ((self.height * 0.5) * _pTransform.scale.y))
      self.left       = round(self.position.x - ((self.width  * 0.5) * _pTransform.scale.x))
      self.right      = round(self.position.x + ((self.width  * 0.5) * _pTransform.scale.x))
    end     

    return bBox  
  end
}