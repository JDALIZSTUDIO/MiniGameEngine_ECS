return {
  new = function(_pMaxTrail)
    local f_component      = Locator:Get_Service("f_component")
    local component        = f_component.new("trailEmitter")
          component.active = true
          component.alpha  = 0.2
          component.trail  = {}
          component.maxT   = _pMaxTrail or 50
    
    local insert = table.insert
    local remove = table.remove
    local an     = "animator"
    local tr     = "transform"

    ------------
    -- Update --
    ------------
    function component:Update(dt, _pEntity)
      if(component.active) then
        local transform = _pEntity:Get_Component(tr)
        local length = #component.trail
        if(length > component.maxT) then remove(component.trail, 1) end
        local frame = 1
        local animator = self.gameObject:Get_Component(an)
        if(animator ~= nil) then frame = animator.currentFrame end
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

    function component:Draw(_pSRenderer, _pAnimator)
      if(_pSRenderer ~= nil) then self:Draw_SpriteRender(_pSRenderer) end
      if(_pAnimator  ~= nil) then self:Draw_Animator(_pAnimator)      end
    end

    -------------------
    -- Draw_Animator --
    -------------------
    function component:Draw_Animator(_pAnimator)
      if(not _pAnimator.active) then return end
      local length = #self.trail
      if(length < 1) then return end
      
      local alpha, pos
      for i = 1, length do            
        alpha = i / length * _pAnimator.alpha * self.alpha
        love.graphics.setColor(0.5, 0.5, 0.5, alpha * _pAnimator.alpha)
        
        trail = self.trail[i]
        love.graphics.draw(
          _pAnimator.currentAnimation.sprite.image,
          _pAnimator.currentAnimation.quadData[_pAnimator.currentFrame],
          trail.x, 
          trail.y, 
          math.rad(trail.rotation), 
          trail.scale.x, 
          trail.scale.y, 
          _pAnimator.currentAnimation.halfW, 
          _pAnimator.currentAnimation.halfH,
          0,
          0
        )
      end
    end

    -----------------------
    -- Draw_SpriteRender --
    -----------------------
    function component:Draw_SpriteRender(_pSRenderer)
      if(not _pSRenderer.active) then return end
      if(not _pAnimator.active) then return end
      local length = #self.trail
      if(length < 1) then return end
      
      local alpha, pos
      for i = 1, length do            
        alpha = i / length * _pSRenderer.alpha * self.alpha
        love.graphics.setColor(0.5, 0.5, 0.5, alpha)        
        trail = self.trail[i]
        love.graphics.draw(
          _pAnimator.sprite.image, 
          trail.x, 
          trail.y, 
          math.rad(trail.rotation), 
          trail.scale.x, 
          trail.scale.y, 
          _pAnimator.sprite.halfW, 
          _pAnimator.sprite.halfH,
          0,
          0
        )
      end
    end
    
    return component
    
  end
}
