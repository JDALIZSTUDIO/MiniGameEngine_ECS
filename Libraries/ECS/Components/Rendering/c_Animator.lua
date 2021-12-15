return {
  new = function()
    local Animator = p_Component.new("animator")
          Animator.animations       = {}
          Animator.currentAnimation = nil
          Animator.currentFrame     = 1
          Animator.frameCounter     = 0
          Animator.shader           = {}          
          Animator.surfacePing      = nil
          Animator.surfacePong      = nil
        
    function Animator:Add(_pID, _pPath, _pW, _pH, _pOffsetX, _pOffsetY, _pStartX, _pStartY, _pEndX, _pEndY)
      local image         = love.graphics.newImage(_pPath)
      local imageWidth    = image:getWidth()
      local imageHeight   = image:getHeight()
      
      local animation     = {
            atlas         = image,
            atlasWidth    = imageWidth,
            atlasHeight   = imageHeight,
            finished      = false,
            frameWidth    = _pW or imageWidth,
            frameHeight   = _pH or imageHeight,
            name          = _pID,
            offset        = Vector2.new(-_pOffsetX or 0, -_pOffsetY or 0),
            quadData      = {},
            speed         = 7
      }
        
      local col   = _pStartX or 1
      local lig   = _pStartY or 1
      local nbCol = math.max(1, _pEndX or math.floor(animation.atlasWidth  /  animation.frameWidth))
      local nbLig = math.max(1, _pEndY or math.floor(animation.atlasHeight / animation.frameHeight))
      
      local quad
      for y = lig, nbLig, 1 do
        for x = col, nbCol, 1 do
          quad = love.graphics.newQuad((x-1) * animation.frameWidth,
                                       (y-1) * animation.frameHeight,
                                       animation.frameWidth,
                                       animation.frameHeight,
                                       animation.atlas:getDimensions());
                                     
          table.insert(animation.quadData, quad)
        end
      end
      
      self.animations[_pID] = animation      
        if(debug) then print("Animation added:      ".._pID..", "..tostring(#animation.quadData).." quads") end
      Animator:Play(_pID)
      
      return animation
    end
    
    function Animator:Play(_pID)
      if(self.currentAnimation == nil) then
        self.currentAnimation = self.animations[_pID]
        
      else
        if(_pID ~= self.currentAnimation.name) then
          self.currentAnimation          = self.animations[_pID]
          self.currentAnimation.finished = false        
          self.frameCounter              = 0
          self.currentFrame              = 0
          
        end
      end      
    end
  
    return Animator
  end
}