  return {
    new = function()      
      local aspect  = Locator:Get_Service("aspect")
      local CDStart = {
        finished    = false
      }
        
        ------------------
        -- Declarations --
        ------------------
        local state        = nil
        local timers       = nil
        local countDown    = nil
        local maxScale     = 16
        local minScale     = 4
        local startCounter = 3
        local GUI          = nil
        
        function Create_Countdown()
          local imgFont = love.graphics.newImageFont('Game/Images/SpriteFonts/spr_Kromasky.png',' abcdefghijklmnopqrstuvwxyz0123456789!?:;,è./+%ç@à#')
          countDown     = GUI:Add(GUI:SpriteFont(Round(aspect.window.width/2) - 16, Round(aspect.window.height/2), tostring(startCounter), imgFont, 3))
          countDown.sX  = maxScale
          countDown.sY  = maxScale
          
        end
        
        ----------
        -- Load --
        ----------
        function CDStart:Load()
          timers = require('Core/Libraries/Timers').new()
          state  = require('Core/Libraries/State_Machine').new({"WAIT", "COUNT", "FINISH", "END"})          
          GUI    = require('Core/Libraries/GUI/GUI_Factory')          
          
          timers:Add_Timer("wait",  1)
          timers:Add_Timer("count", 1)          
          timers:Start("wait")          
          state:Set("WAIT")
        end

        function CDStart:Unload()
          
        end

        ------------
        -- Update --
        ------------
        function CDStart:Update(dt)
          if(state:Compare("WAIT")) then
            if(timers:Is_Finished("wait")) then
              Create_Countdown()
              timers:Start("count")
              state:Set("COUNT")
              
            end
            
          elseif(state:Compare("COUNT")) then  
            if(timers:Is_Finished("count")) then
              startCounter = startCounter - 1
              if(startCounter < 0) then
                countDown.alpha = Lerp(countDown.alpha, 0, 0.2)
                if(countDown.alpha <= 0.01) then
                  state:Set("FINISH")
                end
              
              else
                countDown:SetLabel(tostring(startCounter))
                countDown.sX  = maxScale
                countDown.sY  = maxScale
                timers:Start("count")
              end
            else
              countDown.sX = Lerp(countDown.sX, minScale, 0.1)
              countDown.sY = Lerp(countDown.sY, minScale, 0.1)
              
            end
            
          elseif(state:Compare("FINISH")) then
            self.finished = true
            
          end          
          
          GUI:Update(dt)
          timers:Update(dt)          
        end

        ----------
        -- Draw --
        ----------
        function CDStart:Draw()
          
        end

        -------------
        -- Draw_GUI --
        -------------
        function CDStart:Draw_GUI()
          GUI:Draw()
          
        end
        
      return CDStart
    end
  }