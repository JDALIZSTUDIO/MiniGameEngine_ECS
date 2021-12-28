return {
  new = function()
    local f_component                = Locator:Get_Service("f_component")
    local component                  = f_component.new("animator")
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
    function component:Add(_pID, _pSprite, _pFrameW, _pFrameH, _pOffsetX, _pOffsetY, _pStartX, _pStartY, _pEndX, _pEndY, _pSpeed, _pLoop)
      local loop = _pLoop
      if(loop == nil) then loop = true end

      local animation     = {
            sprite        = _pSprite,
            finished      = false,
            frameWidth    = _pFrameW,
            frameHeight   = _pFrameH,
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
  
    return component
  end
}