return {
  new = function() 
    local f_system = Locator:Get_Service("f_system")
    local system   = f_system.new({"transform", "animator"})
    
    local an  = "animator"
    local ds  = "dropShadow"
    local tr  = "transform"

    ----------
    -- Load --
    ----------
    function system:Load(_pEntity)
      if(isDebug) then print("Systems, loaded:      s_Animator by ".._pEntity.name) end
    end
    
    ------------
    -- Update --
    ------------
    function system:Update(dt, _pEntity)      
      local animator = _pEntity:Get_Component(an)
      if(animator.active == false) then return end
      if(animator.currentAnimation == nil) then return end
      
      local length = #animator.currentAnimation.quadData

      if(animator.currentAnimation.isLoop) then
        animator.frameCounter = animator.frameCounter + (dt * animator.currentAnimation.speed)

        if(animator.currentFrame > length-1 and 
          animator.frameCounter >= 0.5) then
            animator.currentAnimation.finished = true
        end

        if(animator.frameCounter >= 1) then
          animator.frameCounter = 0
          animator.currentFrame = animator.currentFrame+1

          if(animator.currentFrame > length) then
            animator.currentFrame = 1
          end
        end

      else
        if(animator.currentFrame < length) then
          animator.frameCounter = animator.frameCounter + (dt * animator.currentAnimation.speed)
          if(animator.frameCounter >= 1) then
            animator.frameCounter = 0
            animator.currentFrame = animator.currentFrame+1
          end
        else
          animator.currentFrame              = length
          animator.currentAnimation.finished = true
        end
      end
    end
    
    ----------
    -- Draw --
    ----------
    function system:Draw(_pEntity)      
      local animator = _pEntity:Get_Component(an)
      if(animator.active == false) then return end

      local dropShadow = _pEntity:Get_Component(ds)
      local transform  = _pEntity:Get_Component(tr)
      if(dropShadow ~= nil) then        
        animator:Draw_Dropshadow(transform, dropShadow)
      end      
      animator:Draw(transform)
      love.graphics.setColor(1, 1, 1, 1)
    end
    
    return system 
  end
}