local factory  = require('Core/Libraries/ECS/Components/Controllers/c_Character_Controller')

return {
  new = function(_pECS)
    local component = factory.new(_pECS)
          
    local alpha      = 0
    local gameObject
    local lstTanks   = {}
    local maxTanks   = 5
    local state      = nil
    local timers     = nil
    local tName      = "spawn"
    local tDuration  = 2

    local an         = "animator"
    local tr         = "transform"

    local lerp       = Lerp
    local remove     = table.remove

    -------------
    -- Animate --
    -------------
    function component:Animate()
      local animator = gameObject:Get_Component(an)
      local currentState = state:Get()

      if(currentState == "SPAWN") then
        
      elseif(state:Compare("WAIT")) then
        
      elseif(state:Compare("SEARCH")) then
       
      elseif(state:Compare("MOVETO")) then

      elseif(state:Compare("ARRIVE")) then 

      elseif(state:Compare("SHOOT")) then
        
      end
    end

    -----------------
    -- Custom_Load --
    -----------------
    function component:Custom_Load()
        gameObject = self.gameObject

        state = require('Core/Libraries/State_Machine').new({"SPAWN", "WAIT", "SEARCH", "MOVETO", "ARRIVE", "SHOOT"})
        timers = require('Core/Libraries/Timers').new()

        timers:Add(tName, tDuration)
        timers:Start(tName)
        state:Set("SPAWN")
    end
    
    -------------------
    -- Process_Input --
    -------------------
    function component:Process_Input()  
      
    end

    ------------------
    -- Update_Logic --
    ------------------
    function component:Update_Logic(dt)
      local animator     = gameObject:Get_Component(an)

      if(state:Compare("SPAWN")) then        
        local animator = gameObject:Get_Component(an)
              animator:Set_Alpha(alpha)

        alpha = lerp(alpha, 1, 0.01)              

        if(alpha >= 1) then
            state:Set("WAIT")
        end

      elseif(state:Compare("WAIT")) then

      elseif(state:Compare("SEARCH")) then

      elseif(state:Compare("MOVETO")) then
        
      elseif(state:Compare("SHOOT")) then
        
      end
      timers:Update(dt)
    end
    
    -----------------------
    -- OnEntityCollision --
    -----------------------
    function component:OnEntityCollision(_pTable)
      
    end    
    
    return component
  end
}