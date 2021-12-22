return {
  new = function()
    local class = {}    
    
    local floor = math.floor
    local cos   = math.cos
    local sin   = math.sin
    local max   = math.max
    local min   = math.min
    local rad   = math.rad
    local pi    = math.pi

    -----------
    -- Clamp --
    -----------
    function Clamp(n, low, high) return min(max(n, low), high) end

      ----------
      -- Dump --
      ----------
      function Dump(o)
         if type(o) == 'table' then
            local s = '{ '
            for k,v in pairs(o) do
               if type(k) ~= 'number' then k = '"'..k..'"' end
               s = s .. '['..k..'] = ' .. Dump(v) .. ','
            end
            return s .. '} '
         else
            return tostring(o)
         end
      end

      ------------------
      -- Length_Dir_X --
      ------------------
      function Length_Dir_X(_pSpeed, _pDirection)
        return cos(_pDirection) * _pSpeed
      end

      ------------------
      -- Length_Dir_Y --
      ------------------
      function Length_Dir_Y(_pSpeed, _pDirection)
        return sin(_pDirection) * _pSpeed
      end

      ----------
      -- Lerp --
      ----------
      function Lerp(initial_value, target_value, speed)
        local result = (1-speed) * initial_value + speed*target_value
        return result
      end

      ---------
      -- Pow --
      ---------
      function Pow(pA, pB)
          return pA ^ pB
      end

      -----------
      -- Round --
      -----------
      function Sign(pNumber)
        return pNumber > 0 and 1 or (pNumber == 0 and 0 or -1)
      end
    
      -------------
      -- Modulus --
      -------------
      function Modulus(pA, _pB)
        return pA - (floor(pA/_pB)*_pB)
      end

      -----------
      -- Round --
      -----------
      function Round(num, idp)
        local mult = 10^(idp or 0)
        return floor(num * mult + 0.5) / mult
      end

      -----------------
      -- SmoothAngle --
      -----------------
      function Smooth_Angle(current, goal, speed, dt)
          local diff = (goal-current+pi)%(2*pi)-pi
          return current + (diff * speed) * dt
      end

      ---------
      -- Cos --
      ---------
      function Cos(pA) return cos(rad(pA)) end

      ---------
      -- Sin --
      ---------
      function Sin(pA) return sin(rad(pA)) end

      
    return class
  end
}