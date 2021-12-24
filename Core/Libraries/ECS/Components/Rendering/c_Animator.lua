return {
  new = function()
    local component = p_Component.new("animator")
          component.alpha            = 1
          component.animations       = {}
          component.currentAnimation = nil
          component.currentFrame     = 1
          component.frameCounter     = 0
          component.shader           = {}          
          component.surfacePing      = nil
          component.surfacePong      = nil
    
    local max     = math.max
    local floor   = math.floor
    local newQuad = love.graphics.newQuad

    local an = "animator"
    local sr = "spriteRenderer"
    local tr = "transform"

    local insert  = table.insert 

    ---------
    -- Add --
    ---------
    function component:Add(_pID, _pPath, _pW, _pH, _pOffsetX, _pOffsetY, _pStartX, _pStartY, _pEndX, _pEndY)
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
      local nbCol = max(1, _pEndX or floor(animation.atlasWidth  /  animation.frameWidth))
      local nbLig = max(1, _pEndY or floor(animation.atlasHeight / animation.frameHeight))
      
      local quad
      for y = lig, nbLig, 1 do
        for x = col, nbCol, 1 do
          quad = newQuad((x-1) * animation.frameWidth,
                         (y-1) * animation.frameHeight,
                          animation.frameWidth,
                          animation.frameHeight,
                          animation.atlas:getDimensions());
                                     
          insert(animation.quadData, quad)
        end
      end
      
      self.animations[_pID] = animation      
        if(isDebug) then print("Animation added:      ".._pID..", "..tostring(#animation.quadData).." quads") end
        if(self.currentAnimation == nil) then self:Play(_pID) end
      
      return animation
    end
    
    --------------
    -- Get_Name --
    --------------
    function component:Get_Name()
      return component.currentAnimation.name
    end

    function component:Set_Alpha(_pAlpha)
      component.alpha = _pAlpha
      local transform = component.gameObject:Get_Component(tr)
      local child, renderer
      for i = 1, #transform.children do
        child = transform.children[i].transform.gameObject
        renderer = child:Get_Component(an)
        if(renderer ~= nil) then renderer.alpha = _pAlpha end
        renderer = child:Get_Component(sr)
        if(renderer ~= nil) then renderer.alpha = _pAlpha end
      end
    end

    -----------------
    -- Is_Finished --
    -----------------
    function component:Is_Finished(_pName)
      if(self.Get_Name() == _pName) then
        return self.currentAnimation.finished
      end
      return false
    end

    ----------
    -- Play --
    ----------
    function component:Play(_pID)
      if(self.currentAnimation == nil) then
        self.currentAnimation = self.animations[_pID]
      else
        if(_pID ~= self.currentAnimation.name) then
          self.currentAnimation          = self.animations[_pID]
          self.currentAnimation.finished = false        
          self.frameCounter              = 0
          self.currentFrame              = 1          
        end
      end      
    end
  
    return component
  end
}