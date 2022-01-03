return {
  new = function(_pX, _pY)
      local Class   = {
        active      = true,
        alpha       = 1,
        expired     = false,
        position    = { x = _pX or 0, y = _pY or 0 },
        scale       = { x = 1,   y = 1 },
        targetScale = 1.2,
        rotation    = 0,
        lSpeedIN    = 0.1,
        lSpeedOUT   = 0.2
      }
      
      --------------
      -- Alpha_To --
      --------------
      function Class:Alpha_To(_pScalar, _pSpeed)
        if(self.alpha == _pScalar) then return end
        self.alpha = self:Lerp(self.alpha, _pScalar, _pSpeed)
      end
      
      ------------------
      -- Get_Position --
      ------------------
      function Class:Get_Position()
        return self.position
      end      

      ----------
      -- Lerp --
      ----------
      function Class:Lerp(_pInitial, _pTarget, _pSpeed)
        return ( 1 - _pSpeed) * _pInitial + _pSpeed * _pTarget
      end
      
      ----------
      -- Load --
      ----------
      function Class:Load()
        
      end

      ------------------
      -- Set_Position --
      ------------------
      function Class:Set_Position(_px, _pY)
        self.position = {
          x = _pX,
          y = _pY
        }
      end
      
      ----------------------
      -- Set_Target_Scale --
      ----------------------
      function Class:Set_Target_Scale(_pScalar)
        self.targetScale = _pScalar
      end
      
      --------------
      -- Scale_To --
      --------------
      function Class:Scale_To(_pScalar, _pSpeed)
        if(self.scale.x == _pScalar and self.scale.y == _pScalar) then return end
        self.scale = {
          x = self:Lerp(self.scale.x, _pScalar, _pSpeed),
          y = self:Lerp(self.scale.y, _pScalar, _pSpeed)
        }
      end
      
      ------------
      -- Update --
      ------------
      function Class:Update(dt)
        
      end

      -------------------
      -- Update_Active --
      -------------------
      function Class:Update_Inactive()
        self.Alpha_To(0, self.lSpeedOUT)
        self:Scale_To(0, self.lSpeedOUT)
      end

      ----------
      -- Draw --
      ----------
      function Class:Draw()
            
      end

      return Class
  end
}