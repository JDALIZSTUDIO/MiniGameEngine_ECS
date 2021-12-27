local element = require('Core/Libraries/GUI/Elements/GUI_Element')

return {
    new = function(_pX, _pY, _pString)
        local Class = element.new(_pX, _pY)
              Class.centered = true
              Class.font     = love.graphics.newFont(14)
              Class.label    = _pString
              Class.labelW   = Class.font:getWidth(_pString)
              Class.labelH   = Class.font:getHeight(_pString)
              Class.shadow   = { x = 4, y = 4 }
            
            local rad = math.rad

            ----------
            -- Load --
            ----------
            function Class:Load()
                --self.font = love.graphics.newFont(_pFontSize or 14)
            end
            
            ----------------
            -- Draw_Label --
            ----------------
            function Class:Draw_Label()
                if(self.label == "") then return end
                love.graphics.setFont(self.font)
                love.graphics.setColor(0, 0, 0, 0.2 * self.alpha)
                    love.graphics.print(
                        self.label, 
                        self.position.x + self.shadow.x, 
                        self.position.y + self.shadow.y, 
                        rad(self.rotation), 
                        self.scale.x, 
                        self.scale.y, 
                        self.labelW*0.5, 
                        self.labelH*0.5,
                        0,
                        0
                    )
                                    
                love.graphics.setColor(1, 1, 1, self.alpha)
                    love.graphics.print(
                        self.label, 
                        self.position.x, 
                        self.position.y, 
                        rad(self.rotation), 
                        self.scale.x, 
                        self.scale.y,
                        self.labelW*0.5, 
                        self.labelH*0.5,
                        0,
                        0
                    )
            end
            
            --------------
            -- Set_Font --
            --------------
            function element:Set_Font(_pfont, _pSize)
                self.font   = love.graphics.newFont(_pfont, _pSize)
                self.labelW = self.font:getWidth(self.label)
                self.labelH = self.font:getHeight(self.label)
            end
            
            ----------------
            -- Set_Shadow --
            ----------------
            function Class:Set_Shadow(_pX, _pY)
                self.shadow = {
                    x = _pX,
                    y = _pY
                }
            end
            
            ------------
            -- Update --
            ------------
            function Class:Update(dt)
                if(Class.active) then
                    Class:Alpha_To(1, Class.lSpeedIN)
                else
                    self:Update_Inactive()
                end
            end

            ----------
            -- Draw --
            ----------
            function Class:Draw()
                Class:Draw_Label()
            end

        return Class
    end
}