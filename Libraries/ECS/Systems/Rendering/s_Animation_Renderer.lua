return {
  new = function() 
    local system = p_System.new({"transform", "animator"})
    
    local an = "animator"
    local tr = "transform"

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
      local animator = _pEntity:GetComponent(an)
      if(animator.active == false) then return end
      if(animator.currentAnimation == nil) then return end
      
      animator.frameCounter = animator.frameCounter + (dt * animator.currentAnimation.speed)      
      if(animator.frameCounter >= 1) then
        animator.frameCounter = 0
        animator.currentFrame = animator.currentFrame+1
        
        if(animator.currentFrame > #animator.currentAnimation.quadData) then
          animator.currentFrame = 1
          
        end
      end
      
      animator.currentAnimation.finished = false
      if(animator.currentFrame == #animator.currentAnimation.quadData and 
         animator.frameCounter >= 0.9) then
        animator.currentAnimation.finished = true
        
      end
    end
    
    function system:Draw(_pEntity)
      
      local animator = _pEntity:GetComponent(an)
      if(animator.active == false) then return end
      
      local current  = animator.currentAnimation
      if current == nil then return end      
      
      local transform = _pEntity:GetComponent(tr)
      
      love.graphics.draw(current.atlas, 
                         current.quadData[animator.currentFrame], 
                         transform.position.x + current.offset.x, 
                         transform.position.y + current.offset.y,
                         math.rad(transform.rotation),
                         transform.scale.x,
                         transform.scale.y,
                         current.frameWidth/2,
                         current.frameHeight/2) 
    end
    
    return system 
  end
}