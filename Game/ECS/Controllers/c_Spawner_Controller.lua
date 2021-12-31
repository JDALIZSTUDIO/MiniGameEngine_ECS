return {
  new = function()
    local f_character = Locator:Get_Service("f_character")
    local component   = f_character.new()
          
    local gameObject
    local lstTanks   = {}
    local maxTanks   = 0
    local state      = nil
    local timers     = nil
    local tName      = "spawn"
    local tDuration  = 4

    local an         = "animator"
    local ch         = "characterController"
    local tr         = "transform"

    local insert     = table.insert
    local remove     = table.remove

    local factory

    --------------
    -- Clean_Up --
    --------------
    function component:Clean_Up()
      local tank
      for i = #lstTanks, 1, -1 do
        tank = lstTanks[i]
        if(tank == nil) then remove(lstTanks, i) end
      end
    end

    ----------
    -- Load --
    ----------
    function component:Load()
      factory    = require('Game/ECS/Factories/f_Enemies').new()
      gameObject = self.gameObject 

      state = require('Core/Libraries/State_Machine').new({"WAITOPEN", "WAITCLOSE", "OPENING", "CLOSING", "OPEN", "CLOSED"})
      timers = require('Core/Libraries/Timers').new()

      timers:Add_Timer(tName, tDuration)
      timers:Start(tName)
      state:Set("CLOSED")
    end
    
    ------------------
    -- On_Animation --
    ------------------
    function component:On_Animation()
      local animator = gameObject:Get_Component(an)
      local current  = state:Get_Name()

      if(current == "WAIT") then
        
      elseif(current == "OPENING") then
        if(animator:Is_Finished("opening")) then          
          self:Spawn_Tank()
          timers:Start(tName)
          state:Set("OPEN")
        else
          animator:Play("opening")
        end
      elseif(current == "CLOSING") then
        if(animator:Is_Finished("closing")) then
          timers:Start(tName)
          state:Set("CLOSED")
        else
          animator:Play("closing")
        end
      elseif(current == "OPEN") then        
        animator:Play("open")

      elseif(current == "CLOSED") then        
        animator:Play("closed")
      end
    end

    --------------
    -- On_Input --
    --------------
    function component:On_Input()  
      
    end

    ------------------------------
    -- On_Collision_With_Entity --
    ------------------------------
    function component:On_Collision_With_Entity(_pTable)
      --if(not state:Compare("DEATH")) then
        local other
        for i = 1, #_pTable do
          other = _pTable[i]
          if(other.name == "bullet") then
            if(self:Hurt(other:Get_Component(ch).damage)) then
              self:Kill()
            end
            other.Destroy()
          end
        end
      --end
    end  
    
    ---------------
    -- On_Update --
    ---------------
    function component:On_Update(dt)
      local animator = gameObject:Get_Component(an)
      local current  = state:Get_Name()

      if(current == "WAIT") then
        if(timers:Is_Finished(tName)) then
          state:Set("OPENING")
        end
      elseif(current == "OPENING") then

      elseif(current == "CLOSING") then

      elseif(current == "OPEN") then
        if(timers:Is_Finished(tName)) then
          state:Set("CLOSING")
        end
      elseif(current == "CLOSED") then
        self:Clean_Up()
        if(#lstTanks < maxTanks) then
          if(animator.Get_Name() == "closed") then
            if(timers:Is_Finished(tName)) then
              state:Set("OPENING")
            end
          end
        end
      end
      timers:Update(dt)
    end    
    
    ----------------
    -- Spawn_Tank --
    ----------------
    function component:Spawn_Tank()
      local transform = gameObject:Get_Component(tr)
      local tank = gameObject.ECS:Create()

      factory:Init_Tank(
        tank, 
        transform.position.x, 
        transform.position.y
      )

      insert(lstTanks, tank)
    end

    return component
  end
}