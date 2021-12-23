return {
    new = function(_pParamaters)
      local _params = _pParamaters or {}

      local component = p_Component.new("health")
            component.defense     = _params.defense    or 0 
            component.damage      = _params.damage     or 0
            component.health      = _params.maxHealth  or 100
            component.maxDefense  = _params.maxDefense or 100
            component.maxHealth   = _params.maxHealth  or 100

      local min = math.min

      ----------
      -- Heal --
      ----------
      function component:Heal(_pValue)
        self.health = self.health + _pValue
        self.health = min(self.health, self.maxHealth)
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

      -----------------
      -- Take_Damage --
      -----------------
      function component:Take_Damage(_pDamage)
        local reduced = _pDamage * (self.defense / self.maxDefense)
        self.health = self.health - reduced
        if(self.health <= 0) then
          self.health = 0
          return true
        else
          return false
        end
      end
        
      return component
    end
  }