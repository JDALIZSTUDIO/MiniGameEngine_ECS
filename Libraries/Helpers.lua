return {
  new = function()
    local class = {}    
    
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
      function Screen_To_World(_pX, _pY)
        return _pX/(love.graphics.getWidth()/Aspect.window.width)/Aspect.scale, _pY/(love.graphics.getHeight()/Aspect.window.height)/Aspect.scale
      end

      -------------
      -- Modulus --
      -------------
      function Modulus(pA, _pB)
        return pA - (math.floor(pA/_pB)*_pB)
      end

      -----------
      -- Round --
      -----------
      function Round(num, idp)
        local mult = 10^(idp or 0)
        return math.floor(num * mult + 0.5) / mult
      end

      -----------------
      -- SmoothAngle --
      -----------------
      function SmoothAngle(current, goal, speed, dt)
          local diff = (goal-current+math.pi)%(2*math.pi)-math.pi
          return current + (diff * speed) * dt
      end

      ---------
      -- Cos --
      ---------
      function Cos(pA) return math.cos(math.rad(pA)) end

      ---------
      -- Sin --
      ---------
      function Sin(pA) return math.sin(math.rad(pA)) end

      
    return class
  end
}