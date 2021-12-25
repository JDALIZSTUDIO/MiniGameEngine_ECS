return {
  new = function() 
    local component = p_Component.new("simpleBody")
          component.isSolid = true

    local cos    = math.cos
    local sin    = math.sin
    local floor  = math.floor
    local insert = table.insert
    local sign   = Sign
    
    local gameObject = nil
    local transform  = nil

    local ch = "characterController"
    local bb = "boundingBox"
    local sb = "simpleBody"
    local tr = "transform"
        
    --------------------
    -- _Get_Direction --
    --------------------
    function component:_Get_Direction()
      return component.gameObject:Get_Component(tr).velocity:Direction()
    end
    
    --------------------
    -- _Get_Direction --
    --------------------
    function component:_Get_Magnitude()
      return component.gameObject:Get_Component(tr).velocity:Magnitude()
    end

    -------------------
    -- _Length_Dir_X --
    -------------------
    function component:_Length_Dir_X(_pSpeed, _pDirection)
      return cos(_pDirection) * _pSpeed
    end

    -------------------
    -- _Length_Dir_Y --
    -------------------
    function component:_Length_Dir_Y(_pSpeed, _pDirection)
      return sin(_pDirection) * _pSpeed
    end

    ----------
    -- Load --
    ----------
    function component:Load()      
      gameObject = self.gameObject

      if(isDebug) then print("Systems, loaded:      s_Rigid_Body by ".._pEntity.name) end
    end    

    ------------
    -- Update --
    ------------
    function component:Update(dt)
      local bBox       = _pEntity:Get_Component(bb)
      local simpleBody = _pEntity:Get_Component(sb)
      local transform  = _pEntity:Get_Component(tr)

      local length = layerWidth * layerHeight
      if(length < 1) then 
        local direction = simpleBody:_Get_Direction()
        local length    = simpleBody.velocity:Magnitude()
        local dx        = simpleBody:_Length_Dir_X(length, direction)
        local dy        = simpleBody:_Length_Dir_Y(length, direction)
        transform.position:Set(
          transform.position.x + (dx * dt),
          transform.position.y + (dy * dt)
        )
      else
        
        local collideX       = self:Collide_Tilemap_Horizontal(dt, bBox, transform)
        local directionX     = simpleBody:_Get_Direction()
        local lengthX        = simpleBody._Get_Magnitude()
        local dx             = simpleBody:_Length_Dir_X(lengthX, directionX)
        transform.position.x = simpleBody.position.x - (dx * dt)
        
        local collideY       = self:Collide_Tilemap_Vertical(dt, bBox, transform)
        local directionY     = simpleBody:_Get_Direction()
        local lengthY        = simpleBody._Get_Magnitude()
        local dy             = simpleBody:_Length_Dir_Y(lengthY, directionY)
        transform.position.y = transform.position.y - (dy * dt)

        if(collideX or collideY) then
          local character = _pEntity:Get_Component(ch)
          if(character ~= nil) then character:On_Tile_Collision(nil) end            
        end  
      end
    end

    ----------
    -- Draw --
    ----------
    function component:Draw()
    end
    
    return component 
  end
}