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
      local an     = "animator"
      local tr     = "transform"
  
      ------------
      -- Update --
      ------------
      function component:Update(dt)
        if(component.active) then
            local animator = self.gameObject:Get_Component(an)
            local transform = self.gameObject:Get_Component(tr)
            local length = #component.trail
            if(length > component.maxT) then remove(component.trail, 1) end
            
            insert(
                component.trail, 
                {
                    ID    = animator:Get_Name(),
                    frame = animator.currentFrame,
                    x     = transform.position.x, 
                    y     = transform.position.y, 
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
  
      function component:Draw(_pSRenderer, _pAnimator)
        if(_pSRenderer ~= nil) then self:Draw_SpriteRender(_pSRenderer) end
        if(_pAnimator  ~= nil) then self:Draw_Animator(_pAnimator)      end
      end
  
      ----------
      -- Draw --
      ----------
      function component:Draw()
        if(not self.active) then return end
        local animator = self.gameObject:Get_Component(an)
        local length   = #self.trail
        if(length < 1) then return end
        
        local alpha, current, pos
        for i = 1, length do            
          alpha = i / length * animator.alpha * self.alpha
          love.graphics.setColor(0.5, 0.5, 0.5, alpha * animator.alpha)
          trail   = self.trail[i]
          current = animator.animations[trail.ID] 
          love.graphics.draw(
            current.sprite.image,
            current.quadData[trail.frame],
            trail.x, 
            trail.y, 
            math.rad(trail.rotation), 
            trail.scale.x, 
            trail.scale.y, 
            current.halfW, 
            current.halfH,
            0,
            0
          )
        end
      end
      
      return component
      
    end
  }
  