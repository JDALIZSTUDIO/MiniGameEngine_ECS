return {
  new = function()
    local obj      = {
      alpha        = 0,
      background   = nil,
      logo         = nil,
      shader_aber  = nil,
      shader_wave  = nil,
      state        = nil,
      expired      = false,
      shadow       = 1
    }
    
    local finished = false
    local timers   = nil
    
    local h_aber   = "aberration"
    local h_time   = "time"
    local h_disp   = "displacement"
    local h_scale  = "scale"

    local cos  = math.cos
    local lerp = Lerp

    ----------
    -- Load --
    ----------
    function obj:Load()
      timers     = require('Core/Libraries/Timers').new()
      timers:Add_Timer(h_aber, 1)
      
      self.state = require('Core/Libraries/State_Machine').new({"MOVE", "STOP", "WAIT", "ABERRATION", "TO_NEXT", "DONE"})
      self.state:Set("MOVE")  
      
      self.shader_aber = require("Core/Libraries/Shader").new("Core/Shaders/shd_Chromatic_Aberration.fs")
      self.shader_aber:SetUniform(h_aber,   2)
      self.shader_aber:SetUniform(h_scale,  1)
      
      self.shader_wave = require("Core/Libraries/Shader").new("Core/Shaders/shd_Wave_Horizontal.fs")
      self.shader_wave:SetUniform(h_time,   0)
      self.shader_wave:SetUniform(h_disp,  64)
      self.shader_wave:SetUniform(h_scale,  1)
      
      self.background = {
        image         = love.graphics.newImage("Game/Images/Logo/BG.png"),
        position      = {
          x           = 0,
          y           = 0,
        },
        scale         = {
          x           = 1,
          y           = 1
        }      
      }
      
      local image = love.graphics.newImage("Game/Images/Logo/Logo.png")
      self.logo   = {
        image     = image,
        position  = {
          x       = 0,
          y       = image:getHeight(),
        },
        scale         = {
          x           = 1,
          y           = 1
        }
      } 
    end
    
    function obj:UnLoad()
      
    end

    ------------
    -- Update --
    ------------
    function obj:Update(dt)
      timers:Update(dt)
      
      local aScale = self.shader_aber:GetUniform(h_scale)
      
      local time   = self.shader_wave:GetUniform(h_time)
      local disp   = self.shader_wave:GetUniform(h_disp)
      local scale  = self.shader_wave:GetUniform(h_scale)
      local speed  = -1
      
      if(self.state:Compare("MOVE")) then
        if(self.logo.position.y > 0) then
          self.logo.position.y = self.logo.position.y + speed
          if(self.logo.position.y <= 0) then 
            self.logo.position.y = 0 
            self.state:Set("STOP")
          end      
        end
        
      elseif(self.state:Compare("STOP")) then
        scale = lerp(scale, 0, 0.05)
        if(scale < 0.01) then
          scale = 0
          timers:Start(h_aber)
          self.state:Set("WAIT")
          
        end
        
      elseif(self.state:Compare("WAIT")) then
        if(timers:Is_Finished(h_aber)) then self.state:Set("ABERRATION") end
        
      elseif(self.state:Compare("ABERRATION")) then
        aScale = lerp(aScale, 0, 0.05)
        if(aScale < 0.01) then
          aScale = 0
          timers:Start(h_aber)
          self.state:Set("TO_NEXT")
          
        end   
        
        self.shader_aber:SetUniform(h_aber,  cos(time) * 128)
        self.shader_aber:SetUniform(h_scale, aScale)
        
      elseif(self.state:Compare("TO_NEXT")) then        
        if(timers:Is_Finished(h_aber)) then 
          self.expired = true
          self.state:Set("DONE")        
        end
        
      end
      
      if(self.alpha < 1) then self.alpha = self.alpha + 0.005 end
      time = time + 10  * dt    
      self.shader_wave:SetUniform(h_time,  time)
      self.shader_wave:SetUniform(h_disp,  disp)
      self.shader_wave:SetUniform(h_scale, scale)

      self.background.scale.x = love.graphics:getWidth()  / self.background.image:getWidth() / Aspect.scale
      self.background.scale.y = love.graphics:getHeight() / self.background.image:getHeight() / Aspect.scale
      self.logo.scale.x       = love.graphics:getWidth()  / self.logo.image:getWidth()  / Aspect.scale
      self.logo.scale.y       = love.graphics:getHeight() / self.logo.image:getHeight() / Aspect.scale
    end

    ----------
    -- Draw --
    ----------
    function obj:Draw()
      love.graphics.setColor(1, 1, 1, 1)
      
      love.graphics.draw(
        self.background.image,
        self.background.position.x,
        self.background.position.y,
        0,
        self.background.scale.x,
        self.background.scale.y
      )
      
      if(self.state:Compare("ABERRATION")) then        
        self.shader_aber:Set()        
      else
        self.shader_wave:Set()        
      end

      love.graphics.setColor(1, 1, 1, self.alpha)
          love.graphics.draw(
            self.logo.image,
            self.logo.position.x,
            self.logo.position.y,
            0,
            self.logo.scale.x,
            self.logo.scale.y
          )
                           
      self.shader_aber:UnSet()
      self.shader_wave:UnSet()
      
    end

  return obj
end
}