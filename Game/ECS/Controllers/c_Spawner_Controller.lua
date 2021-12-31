return {
  new = function()
    local f_character = Locator:Get_Service("f_character")
    local component   = f_character.new()
          
    local gameObject
    local lstTanks   = {}
    local maxTanks   = 1
    local state      = nil
    local timers     = nil
    local tName      = "spawn"
    local tDuration  = 4

    local an         = "animator"
    local bb         = "boundingBox"
    local ch         = "characterController"
    local tr         = "transform"

    local insert     = table.insert
    local remove     = table.remove
    local rnd        = math.random
    local lerp       = Lerp
    
    local tExplo     = 0.2
    local f_enemies

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
      f_enemies  = require('Game/ECS/Factories/f_Enemies').new()      
      gameObject = self.gameObject 

      state = require('Core/Libraries/State_Machine').new(
        {
          "WAITOPEN", 
          "WAITCLOSE", 
          "OPENING", 
          "CLOSING", 
          "OPEN", 
          "CLOSED", 
          "DEATH"
        }
      )
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

    -------------
    -- On_Kill --
    -------------
    function component:On_Kill() 
      local bBox      = self.gameObject:Get_Component(bb)
      local transform = self.gameObject:Get_Component(tr)
      local burst     = self.gameObject.ECS:Create()
            burst:Add_Component(require('Core/Libraries/ECS/Components/Movement/c_Transform').new(
                transform.position.x, 
                transform.position.y, 
                0
              )
            )   

      burst:Add_Component(require('Core/Libraries/ECS/Components/FX/c_Animated_FX_Emitter').new())
      local controller = burst:Add_Component(require('Core/Libraries/ECS/Components/Controllers/c_FX_Burst_Controller').new())
      local params = {
        sprite     = Locator:Get_Service("spriteLoader"):Get_Sprite("explosion2"),
        width      = 100,
        height     = 100,
        col1       = 1,
        lig1       = 1,
        col2       = 60,
        lig2       = 1
      }
      controller:Start(
        params,
        {
          width  = 64,
          height = 64
        },
        tExplo,
        rnd(3, 5)
      )
      state:Set("DEATH")
    end

    ------------------------------
    -- On_Collision_With_Entity --
    ------------------------------
    function component:On_Collision_With_Entity(_pTable)
      if(not state:Compare("DEATH")) then
        local other
        for i = 1, #_pTable do
          other = _pTable[i]
          if(other.name == "bullet") then
            if(self:Hurt(other:Get_Component(ch).damage)) then
              self:On_Kill()
            end
            other.Destroy()
          end
        end
      end
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
      elseif(current == "DEATH") then
        local alpha = lerp(animator.alpha, 0, 0.05)
        if(alpha <= 0.01) then
          alpha = 0
          self.gameObject:Destroy()
        end
        animator:Set_Alpha(alpha)
      end
      timers:Update(dt)
    end    
    
    ----------------
    -- Spawn_Tank --
    ----------------
    function component:Spawn_Tank()
      local transform = gameObject:Get_Component(tr)
      local tank = gameObject.ECS:Create()

      f_enemies:Init_Tank(
        tank, 
        transform.position.x, 
        transform.position.y
      )

      insert(lstTanks, tank)
    end

    return component
  end
}