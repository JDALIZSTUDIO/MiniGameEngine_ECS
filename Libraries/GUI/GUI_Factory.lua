local GUI     = {
  lstElements = {},
}

function GUI:Add(_pElement)
  table.insert(self.lstElements, _pElement)
  return _pElement
end

function GUI:Element(_pX, _pY)
    local element   = {
          active    = true,
          alpha     = 1,
          expired   = false,
          x         = _pX,
          y         = _pY,
          sX        = 1,
          sY        = 1,
          sTarget   = 1.2,
          rotation  = 0,
          lerpSpeed = 0.2,
    }

          function element:Lerp(initial_value, target_value, speed)
            local result = (1-speed) * initial_value + speed*target_value
            return result
          end

          function element:SetTargetScale(_pScalar)
            self.sTarget = _pScalar
          end

          function element:LerpTo(_pScalar, _pSpeed)
            element.sX = self:Lerp(element.sX, _pScalar, _pSpeed)
            element.sY = self:Lerp(element.sY, _pScalar, _pSpeed)
          end

          function element:Draw()
            
          end

          function element:Update(dt)
            
          end

    return element
end

function GUI:Label(_pX, _pY, _pString, _pSize)
    local element = self:Element(_pX, _pY)
          element.font   = love.graphics.newFont(_pSize or 14)
          element.label  = _pString
          element.labelW = element.font:getWidth(_pString)
          element.labelH = element.font:getHeight(_pString)
          element.sX     = _pSize or 1
          element.sY     = _pSize or 1
          element.shadow = 4

    function element:Draw()
      love.graphics.setFont(element.font)
      love.graphics.push()
        love.graphics.setColor(0, 0, 0, 0.2 * self.alpha)
          love.graphics.print(element.label, 
                              element.x + element.shadow, 
                              element.y + element.shadow, 
                              element.rotation, 
                              element.sX, 
                              element.sY, 
                              element.labelW*0.5, 
                              element.labelH*0.5,
                              0,
                              0)
                            
        love.graphics.setColor(1, 1, 1, self.alpha)
          love.graphics.print(element.label, 
                              element.x, 
                              element.y, 
                              element.rotation, 
                              element.sX, 
                              element.sY, 
                              element.labelW*0.5, 
                              element.labelH*0.5,
                              0,
                              0)
      love.graphics.pop()
    end

    function element:SetFont(_pfont, _pSize)
      self.font   = love.graphics.newFont(_pfont, _pSize)
      self.labelW = self.font:getWidth(element.label)
      self.labelH = self.font:getHeight(element.label)
    end
    
    return element
end

function GUI:SpriteFont(_pX, _pY, _pString, _pFont, _pSize)
  local sf          = self:Element(_pX, _pY)
        sf.label    = _pString
        sf.font     = _pFont
        sf.charW    = _pFont:getWidth(" ")
        sf.charH    = _pFont:getHeight(" ")
        sf.array    = {}
        sf.width    = 0
        sf.height   = 0
        sf.shadow   = 4
        sf.totalW   = 0
        sf.TotalH   = 0
        sf.centered = true
        sf.surface  = nil
        sf.padding  = sf.shadow * 2
        sf.sX       = _pSize or 1
        sf.sY       = _pSize or 1
  
  function sf:SetLabel(str)
    sf.array = {}
    local l = string.len(str)
    for i=1, l do    
      table.insert(sf.array, str:sub(i, i))
    end 
    
    sf.width  = #sf.array * sf.charW
    sf.height = #sf.array * sf.charH
    
    sf.totalW = sf.font:getWidth(sf.label)  + sf.padding
    sf.totalH = sf.font:getHeight(sf.label) + sf.padding 
    
  end
  
  function sf:Update(dt)    
    
  end
  
  function sf:SetCanvas(_pString)
    sf.surface = love.graphics.newCanvas(sf.totalW, sf.totalH)
    sf.surface:setFilter("nearest", "nearest", 16)
    
    love.graphics.setCanvas(sf.surface)
      love.graphics.setColor(0,0,0,1)
      love.graphics.rectangle("fill",0,0,sf.totalW,sf.totalH)
    love.graphics.setCanvas()
  end
  
  function sf:Draw()
    love.graphics.setFont(sf.font)
    love.graphics.push()    
      
      love.graphics.setCanvas(sf.surface)
        love.graphics.clear()        
        local x, y
        for i=1, #sf.array do
          x = ((i-1)*sf.charW) + (sf.padding * 0.5)
          y = 0 + (sf.padding * 0.5)
          
          love.graphics.setColor(0, 0, 0, 0.2)
          love.graphics.print(sf.array[i], 
                              x+sf.shadow, 
                              y+sf.shadow)
          
          love.graphics.setColor(1, 1, 1, 1)
          love.graphics.print(sf.array[i], 
                              x, 
                              y)
        end
      love.graphics.setCanvas()
      
      love.graphics.setColor(1, 1, 1, sf.alpha)
      love.graphics.draw(sf.surface, 
                         sf.x,
                         sf.y,
                         sf.rotation,
                         sf.sX,
                         sf.sY,
                         sf.totalW * 0.5,
                         sf.totalH * 0.5)
      
    love.graphics.pop()
  end
  
  
  sf:SetLabel(_pString)
  sf:SetCanvas()
  
  return sf
end

function GUI:Panel(_pX, _pY, _pLabel, _pPath)
  local element = self:Label(_pX, _pY, _pLabel)        
        
  function element:SetPanel(_pPath)
    element.panel = {}
    element.panel.sprite = love.graphics.newImage(_pPath)
    element.panel.width  = element.panel.sprite:getWidth()
    element.panel.height = element.panel.sprite:getHeight()
  end
  
  if(_pPath ~= nil) then
    element:SetPanel(_pPath)
  end
  
  function element:Contains(_pX, _pY)
    local halfW  = (element.panelW * element.sX) * 0.5
    local halfH  = (element.panelH * element.sY) * 0.5
    local left   = _pX >= element.x - halfW
    local right  = _pX <= element.x + halfW
    local top    = _pY >= element.y - halfH
    local bottom = _pY <= element.y + halfH
    return left and right and top and bottom
  end
  
  function element:DrawPanel()
    love.graphics.setColor(0, 0, 0, 0.2 * self.alpha)
    love.graphics.draw(element.panel.sprite, 
                       element.x + element.shadow, 
                       element.y + element.shadow, 
                       element.rotation, 
                       element.sX, 
                       element.sY, 
                       element.panel.width*0.5, 
                       element.panel.height*0.5,
                       0,
                       0)
                     
    love.graphics.setColor(1, 1, 1, self.alpha)
    love.graphics.draw(element.panel.sprite, 
                       element.x, 
                       element.y, 
                       element.rotation, 
                       element.sX, 
                       element.sY, 
                       element.panel.width*0.5, 
                       element.panel.height*0.5,
                       0,
                       0)
  end
  
  function element:DrawLabel()
    love.graphics.setFont(element.font)
      love.graphics.setColor(0, 0, 0, 0.2 * self.alpha)
        love.graphics.print(element.label, 
                            element.x + element.shadow, 
                            element.y + element.shadow, 
                            element.rotation, 
                            element.sX, 
                            element.sY, 
                            element.labelW*0.5, 
                            element.labelH*0.5,
                            0,
                            0)
    
    
      love.graphics.setColor(1, 1, 1, self.alpha)
        love.graphics.print(element.label, 
                            element.x, 
                            element.y, 
                            element.rotation, 
                            element.sX, 
                            element.sY, 
                            element.labelW*0.5, 
                            element.labelH*0.5,
                            0,
                            0)
    
    
  end
  
  function element:Draw()    
    love.graphics.setFont(element.font)
    love.graphics.push()
        element:DrawPanel()                         
        element:DrawLabel()                          
    love.graphics.pop()
  end

  return element
end

function GUI:Button(_pX, _pY, _pLabel, _pPath, _pNbFrames, _pFN)
  local element = self:Panel(_pX, _pY, _pLabel)
  element.func = _pFN
                
  function element:SetPanel(_pPath, _pNbFrames)
    element.panel = {}
    element.panel.index      = 1
    element.panel.atlas      = love.graphics.newImage(_pPath)
    element.panel.width      = element.panel.atlas:getWidth()
    element.panel.height     = element.panel.atlas:getHeight()
    element.panel.quads      = {}
    element.panel.quadWidth  = math.floor(element.panel.width /_pNbFrames)
    element.panel.quadHeight = element.panel.height      
    
    element.panel.clicked    = false
    
    for i=1, _pNbFrames-1 do
      table.insert(element.panel.quads, love.graphics.newQuad((i-1)*element.panel.quadWidth, 
                                                              0, 
                                                              element.panel.quadWidth, 
                                                              element.panel.quadHeight, 
                                                              element.panel.atlas:getDimensions()))
      
    end
    --print(#element.panel.quads)
  end
  
  element:SetPanel(_pPath, _pNbFrames)    
  
  function element:Activate(pFunc)
    pFunc()
  end    
  
  function element:Interact()
    if(element.active) then
      element:Activate(element.func)
    end      
  end
  
  function element:Contains(_pX, _pY)
    local halfW  = (element.panel.quadWidth  * element.sX) * 0.5
    local halfH  = (element.panel.quadHeight * element.sY) * 0.5
    local left   = _pX >= element.x - halfW
    local right  = _pX <= element.x + halfW
    local top    = _pY >= element.y - halfH
    local bottom = _pY <= element.y + halfH
    return left and right and top and bottom
  end  
  
  function element:Update(dt)
      if(element.active == false) then
        return
      end
      
      local x, y = love.mouse.getPosition()
      local mouseHover = element:Contains(x, y)
      
      if(mouseHover) then
        element.panel.index = 2
        element:LerpTo(element.sTarget, element.lerpSpeed)
        
        if(element.panel.clicked == false) then
          if(love.mouse.isDown(1)) then
            element.panel.index   = 3
            element.panel.clicked = true
            element:Interact()
          end
        end
        
      else
        element.panel.index = 1
        element:LerpTo(1, element.lerpSpeed)
      end      
      
      if(love.mouse.isDown(1) == false) then
        element.panel.clicked = false
      end
    end
    
    
  function element:DrawPanel()
    love.graphics.setColor(0, 0, 0, 0.2 * self.alpha)
      love.graphics.draw(element.panel.atlas,
                         element.panel.quads[element.panel.index], 
                         element.x + element.shadow, 
                         element.y + element.shadow, 
                         element.rotation, 
                         element.sX, 
                         element.sY, 
                         element.panel.quadWidth*0.5, 
                         element.panel.quadHeight*0.5,
                         0,
                         0)
                     
    love.graphics.setColor(1, 1, 1, self.alpha)
      love.graphics.draw(element.panel.atlas,
                         element.panel.quads[element.panel.index], 
                         element.x, 
                         element.y, 
                         element.rotation, 
                         element.sX, 
                         element.sY, 
                         element.panel.quadWidth*0.5, 
                         element.panel.quadHeight*0.5,
                         0,
                         0)
    
  end
  
  function element:DrawLabel()
    love.graphics.setFont(element.font)
      love.graphics.setColor(0, 0, 0, 0.2 * self.alpha)
        love.graphics.print(element.label, 
                            element.x + element.shadow, 
                            element.y + element.shadow, 
                            element.rotation, 
                            element.sX, 
                            element.sY, 
                            element.labelW*0.5, 
                            element.labelH*0.5,
                            0,
                            0)
        
    
    
      love.graphics.setColor(1, 1, 1, self.alpha)
        love.graphics.print(element.label, 
                            element.x, 
                            element.y, 
                            element.rotation, 
                            element.sX, 
                            element.sY, 
                            element.labelW*0.5, 
                            element.labelH*0.5,
                            0,
                            0)
    
    
  end

  return element
end

function GUI:Update(dt)
  local element
  for i = #self.lstElements, 1, -1 do
    element = self.lstElements[i]
    if(element.expired) then
      table.remove(self.lstelements, element)
    else
      element.Update(dt)
    end
  end
end

function GUI:UnLoad()
  self.lstElements = {}
end

function GUI:Draw()
  for i = 1, #self.lstElements do
    self.lstElements[i].Draw()
  end
end

return GUI