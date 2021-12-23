return {
  new = function(pID, pPath, pW, pH)
    local animation     = {
          atlas         = love.graphics.newImage(pPath),
          atlasWidth    = animation.img:getWidth(),
          atlasHeight   = animation.img:getHeight(),
          finished      = false,
          frameWidth    = pW or animation.atlasWidth,
          frameHeight   = pH or animation.atlasHeight,
          quadData      = {}
    }
    
    return animation
  end  
}