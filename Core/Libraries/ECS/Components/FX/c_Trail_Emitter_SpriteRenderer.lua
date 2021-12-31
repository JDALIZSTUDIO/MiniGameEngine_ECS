return {
    new = function(_pMaxTrail, _pAlpha)
      local f_component      = Locator:Get_Service("f_component")
      local component        = f_component.new("trailEmitter")
            component.active = true
            component.alpha  = _pAlpha or 0.2
            component.trail  = {}
            component.maxT   = _pMaxTrail or 50
      
      local insert = table.insert
      local remove = table.remove
      local sr     = "spriteRenderer"
      local tr     = "transform"
  
      ------------
      -- Update --
      ------------
      function component:Update(dt)
        if(component.active) then
          local transform = self.gameObject:Get_Component(tr)
          local length = #component.trail
          if(length > component.maxT) then remove(component.trail, 1) end
          
          insert(
            component.trail, 
            {
              x = transform.position.x, 
              y = transform.position.y, 
              rotation = transform.rotation, 
              scale = { 
                x   = transform.scale.x, 
                y   = transform.scale.y
              }
            }
          )
        end      
      end
      
      -----------
      -- Start --
      -----------
      function component:Start()
        component.active = true
      end
      
      ----------
      -- Stop --
      ----------
      function component:Stop()
        component.active = false
      end
  
      ----------
      -- Draw --
      ----------
      function component:Draw()
        if(not self.active) then return end
        local renderer = self.gameObject:Get_Component(sr)
        local length   = #self.trail
        if(length < 1) then return end
        
        local alpha, pos
        for i = 1, length do            
          alpha = i / length * renderer.alpha * self.alpha
          love.graphics.setColor(0.5, 0.5, 0.5, alpha)        
          trail = self.trail[i]
          love.graphics.draw(
            renderer.sprite.image, 
            trail.x, 
            trail.y, 
            math.rad(trail.rotation), 
            trail.scale.x, 
            trail.scale.y, 
            renderer.sprite.halfW, 
            renderer.sprite.halfH,
            0,
            0
          )
        end
      end
      
      return component
      
    end
  }
  