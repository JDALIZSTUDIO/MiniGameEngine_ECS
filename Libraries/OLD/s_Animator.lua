return {
  new = function() 
    local system = p_System.new({"transform", "animator"})
    
    function system:Load(_pEntity)
      if(debug) then print("Systems, loaded:      s_Animator by ".._pEntity.name) end
    end
    
    function system:Update(dt, _pEntity)      
      local animator = _pEntity:GetComponent("animator")
      if animator.currentAnimation ~= nil then return end
      
      animator.frameCounter = animator.frameCounter + (dt * 20)      
      if animator.frameCounter >= 1 then
        animator.frameCounter = 0
        animator.currentFrame = animator.currentFrame+1
        
        if animator.currentFrame > #animator.currentAnimation.quadData then
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
      local animator = _pEntity:GetComponent("animator")
      local current  = animator.currentAnimation
      if current == nil then return end      
      
      local transform = _pEntity:GetComponent("transform")
      
      love.graphics.draw(current.atlas, 
                         current.quadData[current.currentFrame], 
                         transform.position.x, 
                         transform.position.y,
                         math.rad(transform.position.rotation),
                         transform.scale.x,
                         transform.scale.y,
                         current.frameWidth/2,
                         current.frameHeight/2)
    end
    
    return system 
  end
}