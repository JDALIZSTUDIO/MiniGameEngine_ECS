return {
    new = function()
        local f_character = Locator:Get_Service("f_character")
        local component   = f_character.new()
              component.range  = 96
              component.target = nil

        local state  = nil

        local an     = "animator"
        local ch     = "characterController"
        local ra     = "radar"
        local tr     = "transform"
        
        local atan2       = math.atan2
        local deg         = math.deg
        local rad         = math.rad
        local cos         = math.cos
        local sin         = math.sin
        local smoothAngle = Smooth_Angle
        local rSpeed      = 1
        
        ---------
        -- Aim --
        ---------
        function component:Aim_At(_pX, _pY, _pSpeed, dt)  
            local transform = self.gameObject:Get_Component(tr)
            local dx =   _pX - transform.position.x
            local dy = -(_pY - transform.position.y)
            transform.rotation = deg(smoothAngle(
                rad(transform.rotation),
                atan2(dx, dy),
                _pSpeed,
                dt
            ))
        end    
        
        -------------
        -- Detects --
        -------------
        function component:Detects(_pX, _pY)
            local radar = self.gameObject:Get_Component(ra)
            return(radar:Scan(_pX, _pY))                
        end    

        ----------
        -- Load --
        ----------
        function component:Load()  
            state  = Locator:Get_Service("state_machine").new(
                {
                    "INIT", 
                    "SPAWN",
                    "GAMEPLAY", 
                    "DEATH", 
                    "DONE"
                }
            )
            state:Set("INIT")
        end        
        
        ---------------
        -- On_Update --
        ---------------
        function component:On_Update(dt)
            local current  = state:Get_Name()    
            if(current == "INIT") then
                local other = self.gameObject:Find_Other("player")
                if(other ~= nil) then
                    self.target = other
                    state:Set("GAMEPLAY")
                end

            elseif(current == "SPAWN") then
    
            elseif(current == "GAMEPLAY") then
                local position = self.target:Get_Component(tr).position
                if(self:Detects(position.x, position.y)) then
                    self:Aim_At(position.x, position.y, rSpeed, dt)
                end

            elseif(current == "DEATH") then
            
            elseif(current == "DONE") then
            
            end
        end   

        return component
    end
  }