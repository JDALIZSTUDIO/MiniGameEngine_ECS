return {
  new = function()
    local P = {
      active = true,
      origin = Vector2.new(0, 0),
      speed  = 1,
      layers = {}
    }
    
    function P:Add(_pPath, _pSpeed, _pDirX, _pDirY, _pX, _pY)
      local image  = love.graphics.newImage(_pPath)
      local width  = image:getWidth()
      local height = image:getHeight()
      local layer  = {
        direction  = Vector2.new(_pDirX or 0, _pDirY or 0),
        image      = image,
        position   = Vector2.new(_pX or 0, _pY or 0),
        scale      = Vector2.new(Aspect.screen.width / width  * 0.5,
                                Aspect.screen.height / height * 0.5),
        speed      = _pSpeed,
        visible    = true,
        width      = width,
        height     = height
      }
      
      table.insert(self.layers, layer)
    end
    
    function P:Update(dt, _pOriginX, _pOriginY)
      local oX = _pOriginX or 0
      local oY = _pOriginY or 0
      self.origin:Set(oX, oY)
      
      local layer, speed
      for i = 1, #self.layers do
        layer = self.layers[i]
        speed = layer.speed * dt
        layer.position.x = layer.position.x + speed * layer.direction.x
        layer.position.y = layer.position.y + speed * layer.direction.y
        
        if(layer.direction.x < 0) then
          if(layer.position.x <= -layer.width * layer.scale.x) then
            layer.position.x = layer.width * layer.scale.x
          end
          
        elseif(layer.direction.x > 0) then
          if(layer.position.x >= layer.width * layer.scale.x) then
            layer.position.x = -layer.width * layer.scale.x
          end
        end
        
        if(layer.direction.y < 0) then
          if(layer.position.y <= -layer.height * layer.scale.y) then
            layer.position.y = layer.height * layer.scale.y
          end
          
        elseif(layer.direction.y > 0) then
          if(layer.position.y >= layer.height * layer.scale.y) then
            layer.position.y = -layer.height * layer.scale.y
          end
        end
        
      end
    end
    
    function P:Draw()
      love.graphics.setColor(1, 1, 1, 1)
      
      local layer, x, y
      for i = 1, #self.layers do
        layer = self.layers[i]
        if(layer.visible) then
          
          love.graphics.draw(layer.image,
                             self.origin.x + layer.position.x,
                             self.origin.y + layer.position.y,
                             0,
                             layer.scale.x,
                             layer.scale.y)
           
          
          if(layer.direction.x ~= 0) then
            if(layer.position.x < 0) then
              love.graphics.draw(layer.image,
                             self.origin.x + layer.position.x + layer.width * layer.scale.x,
                             self.origin.y + layer.position.y,
                             0,
                             layer.scale.x,
                             layer.scale.y)
                           
            elseif(layer.position.x > 0) then
              love.graphics.draw(layer.image,
                             self.origin.x + layer.position.x - layer.width * layer.scale.x,
                             self.origin.y + layer.position.y,
                             0,
                             layer.scale.x,
                             layer.scale.y)
            end           
          end
          
          if(layer.direction.y ~= 0) then
            if(layer.position.y < 0) then
              love.graphics.draw(layer.image,
                             self.origin.x + layer.position.x,
                             self.origin.y + layer.position.y + layer.height * layer.scale.y,
                             0,
                             layer.scale.x,
                             layer.scale.y)
                           
            elseif(layer.position.y > 0) then
              love.graphics.draw(layer.image,
                             self.origin.x + layer.position.x,
                             self.origin.y + layer.position.y - layer.height * layer.scale.y,
                             0,
                             layer.scale.x,
                             layer.scale.y)
            end           
          end
          
        end
      end      
    end
    
    return P
  end
}