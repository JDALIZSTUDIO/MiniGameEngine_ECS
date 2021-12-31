return {
  new = function()
    local f_component = Locator:Get_Service("f_component")
    local component   = f_component.new("animator")
          component.alpha            = 1
          component.animations       = {}
          component.currentAnimation = nil
          component.currentFrame     = 1
          component.frameCounter     = 0
          component.shader           = {}          
          component.surfacePing      = nil
          component.surfacePong      = nil
    
    local max         = math.max
    local floor       = math.floor
    local newQuad     = love.graphics.newQuad

    local rad = math.rad
    local an  = "animator"
    local sr  = "spriteRenderer"
    local tr  = "transform"

    local insert  = table.insert 

    ---------
    -- Add --
    ---------
    function component:Add(
      _pID, 
      _pSprite, 
      _pFrameW, 
      _pFrameH, 
      _pOffsetX, 
      _pOffsetY, 
      _pStartX, 
      _pStartY, 
      _pEndX, 
      _pEndY, 
      _pSpeed, 
      _pLoop
    )
      local loop = _pLoop
      if(loop == nil) then loop = true end

      local animation     = {
            sprite        = _pSprite,
            finished      = false,
            frameWidth    = _pFrameW,
            frameHeight   = _pFrameH,
            halfW         = _pFrameW * 0.5,
            halfH         = _pFrameH * 0.5,
            isLoop        = loop,
            name          = _pID,
            offset        = Vector2.new(-_pOffsetX or 0, -_pOffsetY or 0),
            quadData      = {},
            speed         = _pSpeed or 7,
            speedPre      = 0
      }
      
      local col   = _pStartX or 1
      local lig   = _pStartY or 1
      local nbCol = max(1, _pEndX or floor(animation.sprite.width  / animation.frameWidth ))
      local nbLig = max(1, _pEndY or floor(animation.sprite.height / animation.frameHeight))
      
      local quad
      for y = lig, nbLig, 1 do
        for x = col, nbCol, 1 do
          quad = newQuad(
            (x-1) * animation.frameWidth,
            (y-1) * animation.frameHeight,
            animation.frameWidth,
            animation.frameHeight,
            animation.sprite.width,
            animation.sprite.height
          )
                                     
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

    ---------------
    -- Set_Alpha --
    ---------------
    function component:Set_Alpha(_pValue)
      self.alpha = _pValue
      local transform = self.gameObject:Get_Component(tr)
      local cTransform, cRenderer, cAnimator
      for i = 1, #transform.children do
        cTransform = transform.children[i].transform
        cRenderer  = cTransform.gameObject:Get_Component(sr)
        if(cRenderer ~= nil) then cRenderer.alpha = self.alpha end
        cAnimator  = cTransform.gameObject:Get_Component(an)
        if(cAnimator ~= nil) then cAnimator.alpha = self.alpha end
      end
    end

    -------------
    -- Restart --
    -------------
    function component:Restart()
      self.speed = self.speedPre
    end

    ----------
    -- Stop --
    ----------
    function component:Stop()
      self.speed = 0
    end

    -----------------
    -- Is_Finished --
    -----------------
    function component:Is_Finished(_pName)
      if(self:Get_Name() == _pName) then
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
    
    ----------
    -- Draw --
    ----------
    function component:Draw(_ptransform)
      love.graphics.setColor(1, 1, 1, self.alpha)
      love.graphics.draw(
        self.currentAnimation.sprite.image, 
        self.currentAnimation.quadData[self.currentFrame], 
        _ptransform.position.x + self.currentAnimation.offset.x, 
        _ptransform.position.y + self.currentAnimation.offset.y,
        rad(_ptransform.rotation),
        _ptransform.scale.x,
        _ptransform.scale.y,
        self.currentAnimation.halfW,
        self.currentAnimation.halfH
      ) 
    end
  
    ---------------------
    -- Draw_Dropshadow --
    ---------------------
    function component:Draw_Dropshadow(_ptransform, _pShadow)
      love.graphics.setColor(0, 0, 0, _pShadow.alpha * self.alpha)
        love.graphics.draw(
          self.currentAnimation.sprite.image, 
          self.currentAnimation.quadData[self.currentFrame], 
          _ptransform.position.x + self.currentAnimation.offset.x + _pShadow.offset.x, 
          _ptransform.position.y + self.currentAnimation.offset.y + _pShadow.offset.y,
          rad(_ptransform.rotation),
          _ptransform.scale.x,
          _ptransform.scale.y,
          self.currentAnimation.halfW,
          self.currentAnimation.halfH
        )
    end

    return component
  end
}