return {
    new = function(_pOffsetX, _pOffsetY, _pWidth, _pHeight)
      local component = p_Component.new("simpleBody")
            component.isStatic  = false
            component.isTrigger = true
      
      local gameObject = nil
  
      local round = Round
  
      function component:Load()
        gameObject = self.gameObject
      end
  
      ----------------
      -- Intersects --
      ----------------
      function component:Intersects(_pOther)
        local bb         = "boundingBox"
        local componentA = gameObject:GetComponent(bb)
        local componentB = _pOther:GetComponent(bb)
        
        if(componentB == nil) then return false end
        
        local dX  = componentA.position.x - componentB.position.x
        local dY  = componentA.position.y - componentB.position.y
        local aDX = math.abs(dX)
        local aDY = math.abs(dY)      
        local sHW = (componentA.width*0.5)  + (componentB.width*0.5)
        local sHH = (componentA.height*0.5) + (componentB.height*0.5)
        
        if(aDX >= sHW or aDY >= sHH) then
          return false
          
        else        
          
          if(componentA.isTrigger   or 
             componentA.isStatic or
             componentB.isTrigger   or
             componentB.isStatic) then return true end
          
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
      function component:Reflect(_pOther)
        local transform = gameObject:GetComponent("transform")
        local componentA     = gameObject:GetComponent("boundingBox")
        local componentB     = _pOther:GetComponent("boundingBox")
        
        if(componentA.position.y < componentB.top) then 
          transform.velocity.y = -transform.velocity.y 
          
        elseif(componentA.position.y > componentB.bottom) then 
          transform.velocity.y = -transform.velocity.y 
          
        else         
          transform.velocity.x = -transform.velocity.x
          
        end
      end
      
      ---------------------
      -- Update_Collider --
      ---------------------
      function component:Update_Collider(_pTransform) 
        self.position.x = round(_pTransform.position.x + self.offset.x)
        self.position.y = round(_pTransform.position.y + self.offset.y)
        self.top        = round(self.position.y - ((self.height * 0.5) * _pTransform.scale.y))
        self.bottom     = round(self.position.y + ((self.height * 0.5) * _pTransform.scale.y))
        self.left       = round(self.position.x - ((self.width  * 0.5) * _pTransform.scale.x))
        self.right      = round(self.position.x + ((self.width  * 0.5) * _pTransform.scale.x))
      end     
  
      return component  
    end
  }