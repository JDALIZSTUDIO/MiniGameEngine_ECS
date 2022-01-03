return {
    new = function(_pString)
        local GUI = Locator:Get_Service("GUI")
        local Class = {
            alpha    = 1,
            duration = 2,
            finished = false,
            haflW    = 0,
            halfH    = 0,
            width    = 0,
            height   = 0,
            message  = _pString,
            position = {
                x = 0,
                y = 0
            },
            target = {
                x = 0,
                y = 0
            },
            state,
            amount  = 0
        }

        local message
        local aspect, easing, timers
        local sTimer = "wait"
        local dTimer = 2

        ----------
        -- Load --
        ----------
        function Class:Load()
            aspect = Locator:Get_Service("aspect")
            easing = Locator:Get_Service("easing")
            state  = Locator:Get_Service("state_machine").new(
                {
                    "GOTOEND",
                    "WAIT",
                    "GOTOBEGIN",
                    "DONE"
                }
            )
            state:Set("GOTOEND")

            local screenW = love.graphics.getWidth()
            local screenH = love.graphics.getHeight()

            self.width  = screenW
            self.height = screenH * 0.4
            self.haflW  = self.width  * 0.5
            self.haflH  = self.height * 0.5
            self.begin = {
                x = 0,
                y = -screenH*0.5
            }
            self.position = {
                x = self.begin.x,
                y = self.begin.y
            }
            self.target = {
                x = 0,
                y = (screenH * 0.5)  - self.haflH
            }
            
            ------------------
            -- GUI_elements --
            ------------------
            local spriteFont = love.graphics.newImageFont(
                'Game/Images/SpriteFonts/spr_Kromasky.png',
                ' abcdefghijklmnopqrstuvwxyz0123456789!?:;,è./+%ç@à#'
            )
            
            message = GUI:Add(
                GUI.element.spriteFont.new(
                    screenW * 0.5, 
                    self.begin.y, 
                    self.message, 
                    spriteFont, 
                    { 
                        x = 2, 
                        y = 2 
                    }
                )
            )

            timers = Locator:Get_Service("timers").new()
            timers:Add_Timer(sTimer, dTimer)
        end

        ------------
        -- Update --
        ------------
        function Class:Update(dt)
            local current = state:Get_Name()
            if(current == "GOTOEND") then
                self.position = {
                    x = easing.easeInOutQuad(self.amount, self.position.x, self.target.x - self.position.x, self.duration),
                    y = easing.easeInOutQuad(self.amount, self.position.y, self.target.y - self.position.y, self.duration)
                }

                message:Set_Position(
                    message.position.x,
                    self.position.y + self.haflH
                )

                self.amount = self.amount + dt
                if(self.amount > self.duration) then 
                    timers:Start(sTimer)
                    state:Set("WAIT") 
                end

            elseif(current == "WAIT") then
                if(timers:Is_Finished(sTimer)) then
                    self.amount = 0
                    state:Set("GOTOBEGIN") 
                end

            elseif(current == "GOTOBEGIN") then
                self.position = {
                    x = easing.easeInOutQuad(self.amount, self.position.x, self.begin.x - self.position.x, self.duration),
                    y = easing.easeInOutQuad(self.amount, self.position.y, self.begin.y - self.position.y, self.duration)
                }
                
                message:Set_Position(
                    message.position.x,
                    self.position.y + self.haflH
                )

                self.amount = self.amount + dt
                if(self.amount > self.duration) then
                    self.finished = true
                    state:Set("DONE") 
                end
            end

            timers:Update(dt)
        end

        --------------
        -- Draw_GUI --
        --------------
        function Class:Draw_GUI()
            love.graphics.setColor(1, 1, 1, 0.5 * self.alpha)
            love.graphics.rectangle(
                "fill", 
                self.position.x,
                self.position.y,
                self.width,
                self.height
            )

            love.graphics.setColor(1, 1, 1, 1)
            love.graphics.rectangle(
                "line", 
                self.position.x,
                self.position.y,
                self.width,
                self.height
            )
        end

        Class:Load()

        return Class
    end
}