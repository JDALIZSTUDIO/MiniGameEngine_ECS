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
    local tr         = "transform"

    local lerp       = Lerp
    local remove     = table.remove

    -------------
    -- Animate --
    -------------
    function component:Animate()
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

    -----------------
    -- Custom_Load --
    -----------------
    function component:Custom_Load()
        gameObject = self.gameObject

        state = require('Core/Libraries/State_Machine').new({"SPAWN", "WAIT", "SEARCH", "MOVETO", "ARRIVE", "SHOOT"})
        timers = require('Core/Libraries/Timers').new()

        timers:Add_Timer(tName, tDuration)
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
    -- On_Entity_Collision --
    -----------------------
    function component:On_Entity_Collision(_pTable)
      
    end    
    
    return component
  end
}