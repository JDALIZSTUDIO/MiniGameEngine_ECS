return {
  new = function() 
    local system = p_System.new({"transform", "animator"})
    
    local rad = math.rad
    local an  = "animator"
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
         animator.frameCounter >= 0.8) then
        animator.currentAnimation.finished = true        
      end
    end
    
    function system:Draw(_pEntity)
      
      local animator = _pEntity:Get_Component(an)
      if(animator.active == false) then return end
      
      local current  = animator.currentAnimation
      if current == nil then return end      
      
      local transform = _pEntity:Get_Component(tr)
      
      love.graphics.setColor(1, 1, 1, animator.alpha)

      love.graphics.draw(current.atlas, 
                         current.quadData[animator.currentFrame], 
                         transform.position.x + current.offset.x, 
                         transform.position.y + current.offset.y,
                         rad(transform.rotation),
                         transform.scale.x,
                         transform.scale.y,
                         current.frameWidth  * 0.5,
                         current.frameHeight * 0.5) 

      love.graphics.setColor(1, 1, 1, 1)
    end
    
    return system 
  end
}