return {
    new = function(_pParamaters)
      local f_component = Locator:Get_Service("f_component")
      local _params     = _pParamaters or {}

      local component = f_component.new("health")
            component.defense    = _params.defense    or 0 
            component.damage     = _params.damage     or 0
            component.health     = _params.maxHealth  or 100
            component.maxDefense = _params.maxDefense or 100
            component.maxHealth  = _params.maxHealth  or 100
            
      
      local aspect    = nil
      local alpha     = 1
      local camera    = nil
      local state     = nil
      local timers    = nil
      local tName     = "wait"
      local tDuration = 3

      local targetHealth

      local lerp = Lerp
      local min  = math.min

      local bb = "boundingBox"

      ----------
      -- Load --
      ----------
      function component:Load()
        aspect = Locator:Get_Service("aspect")
        camera = Locator:Get_Service("camera")
        state  = require('Core/Libraries/State_Machine').new({"SHOW", "HIDE"})
        timers = require('Core/Libraries/Timers').new()

        state:Set("HIDE")
        timers:Add_Timer(tName, tDuration)

        targetHealth = self.health
      end

      ----------
      -- Heal --
      ----------
      function component:Heal(_pValue)
        self.health = self.health + _pValue
        self.health = min(self.health, self.maxHealth)
      end

      ----------
      -- Hurt --
      ----------
      function component:Hurt(_pDamage)
        local reduced = _pDamage * (self.defense / self.maxDefense)
        self.health = self.health - (_pDamage - reduced)
        if(self.health <= 0) then
          self.health = 0
          return true
        else
          timers:Start(tName)
          state:Set("SHOW")
          return false
        end
      end

      -------------------------
      -- Increase_Max_Health --
      -------------------------
      function component:Increase_Max_Health(_pValue)
        self.maxHealth = self.maxHealth + _pValue
      end
      
      --------------------------
      -- Increase_Max_Defense --
      --------------------------
      function component:Increase_Max_Defense(_pValue)
        self.maxDefense = self.maxDefense + _pValue
      end

      ---------------------
      -- Restore_Defense --
      ---------------------
      function component:Restore_Defense(_pValue)
        self.defense = self.defense + _pValue
        self.defense = min(self.defense, self.maxDefense)
      end
      
      ------------
      -- Update --
      ------------
      function component:Update(dt)
        local current = state:Get_Name()
        if(current == "SHOW") then
          if(alpha < 0.99) then            
            alpha = lerp(alpha, 1, 0.1)
          else
            alpha = 1
            if(timers:Is_Finished(tName)) then state:Set("HIDE") end
          end 
        else
          if(alpha > 0.01) then
            alpha = lerp(alpha, 0, 0.2)
          else
            alpha = 0
          end
        end
        if(targetHealth ~= self.health) then targetHealth = lerp(targetHealth, self.health, 0.05) end
        timers:Update(dt)
      end

      ----------
      -- Draw --
      ----------
      function component:Draw()
        
      end
        
      --------------
      -- Draw_GUI --
      --------------
      function component:Draw_GUI()
        local bBox = self.gameObject:Get_Component(bb)
        if(bBox == nil) then return end

        local padding = bBox.width * 0.2
        local panelW  = (bBox.width * 2) - (padding*2)
        local panelH  = bBox.height * aspect.scale * 0.2
        local panelX  = bBox.left   + (padding*0.5)
        local panelY  = bBox.top    - (bBox.height * 0.4)

        local _x, _y  = camera:World_To_Screen(panelX, panelY)

        local hValue  = self.health  / self.maxHealth
        local tValue  = targetHealth / self.maxHealth
        local healthW = hValue * panelW
        local targetW = tValue * panelW

        -- background
        love.graphics.setColor(228/255, 59/255, 68/255, 0.5 * alpha)
        love.graphics.rectangle("fill", _x, _y, panelW, panelH)

        -- target bar
        love.graphics.setColor(254/255, 231/255, 97/255, alpha)
        love.graphics.rectangle("fill", _x, _y, targetW, panelH)

        -- health bar
        love.graphics.setColor(99/255, 199/255, 77/255, alpha)
        love.graphics.rectangle("fill", _x, _y, healthW, panelH)

        -- frame
        love.graphics.setColor(1, 1, 1, alpha)
        love.graphics.rectangle("line", _x, _y, panelW, panelH)

        love.graphics.setColor(1, 1, 1, 1)
      end

      component:Load()

      return component
    end
  }