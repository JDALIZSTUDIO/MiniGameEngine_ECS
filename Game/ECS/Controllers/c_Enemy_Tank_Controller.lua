return {
  new = function()
      local f_character      = Locator:Get_Service("f_character")
      local component        = f_character.new()
            component.target = nil
            
      local alpha      = 0
      local gameObject
      local lstTanks   = {}
      local maxTanks   = 5
      local state      = nil
      local target     = nil
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

          state  = Locator:Get_Service("state_machine").new(
            {
              "INIT",
              "SPAWN", 
              "WAIT", 
              "SEARCH", 
              "MOVETO", 
              "ARRIVE", 
              "SHOOT"
            }
          )
          timers = Locator:Get_Service("timers").new()

          timers:Add_Timer(tName, tDuration)
          timers:Start(tName)
          state:Set("INIT")
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
        if(current == "INIT") then 
          local other = self.gameObject:Find_Other("player")
          if(other ~= nil) then
              self.target = other
              state:Set("SPAWN")
          end

        elseif(current == "SPAWN") then        
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
                self:On_Kill()
              end
              other.Destroy()
            end
          end
        --end
      end 

    return component
  end
}