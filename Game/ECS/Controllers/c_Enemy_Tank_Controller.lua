return {
  new = function()
    local f_character = Locator:Get_Service("f_character")
    local component   = f_character.new()
          
    local alpha      = 0
    local gameObject
    local lstTanks   = {}
    local maxTanks   = 5
    local state      = nil
    local timers     = nil
    local tName      = "spawn"
    local tDuration  = 2

    local an         = "animator"
    local ch         = "characterController"
    local tr         = "transform"

    local lerp       = Lerp
    local remove     = table.remove

    -------------
    -- On_Animation --
    -------------
    function component:On_Animation()
      local animator = gameObject:Get_Component(an)
      local current  = state:Get_Name()

      if(current == "SPAWN") then
        
      elseif(current == "WAIT") then
        
      elseif(current == "SEARCH") then
       
      elseif(current == "MOVETO") then

      elseif(current == "ARRIVE") then 

      elseif(current == "SHOOT") then
        
      end
    end

    ----------
    -- Load --
    ----------
    function component:Load()
        gameObject = self.gameObject

        state = require('Core/Libraries/State_Machine').new({"SPAWN", "WAIT", "SEARCH", "MOVETO", "ARRIVE", "SHOOT"})
        timers = require('Core/Libraries/Timers').new()

        timers:Add_Timer(tName, tDuration)
        timers:Start(tName)
        state:Set("SPAWN")
    end
    
    -------------------
    -- On_Input --
    -------------------
    function component:On_Input()  
      
    end

    ------------------
    -- On_Update --
    ------------------
    function component:On_Update(dt)
      local animator = gameObject:Get_Component(an)
      local current  = state:Get_Name()

      if(current == "SPAWN") then        
        local animator = gameObject:Get_Component(an)
              animator:Set_Alpha(alpha)

        alpha = lerp(alpha, 1, 0.01)              

        if(alpha >= 1) then
            state:Set("WAIT")
        end

      elseif(current == "WAIT") then

      elseif(current == "SEARCH") then

      elseif(current == "MOVETO") then
        
      elseif(current == "SHOOT") then
        
      end
      timers:Update(dt)
    end
    
    
    -----------------------
    -- On_Collision_With_Entity --
    -----------------------
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
    
    return component
  end
}