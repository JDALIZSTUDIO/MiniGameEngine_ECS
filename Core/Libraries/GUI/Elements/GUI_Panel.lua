local label = require('Core/Libraries/GUI/Elements/GUI_Label')

return {
    new = function(_pX, _pY, _pString, _pImagePath)
        local Class = label.new(_pX, _pY, _pString)
              Class.mouseHover = false
            
            local rad  = math.rad
            local path = _pImagePath
            
            --------------
            -- Contains --
            --------------
            function Class:Contains(_pX, _pY)
                local halfW  = (Class.panel.frameWidth  * Class.scale.x) * 0.5
                local halfH  = (Class.panel.frameHeight * Class.scale.y) * 0.5
                local left   = _pX >= Class.position.x - halfW
                local right  = _pX <  Class.position.x + halfW
                local top    = _pY >= Class.position.y - halfH
                local bottom = _pY <  Class.position.y + halfH
                return left and right and top and bottom
            end
            
            ------------
            -- Input ---
            ------------
            function Class:_Input()                
                local mx, sx = love.mouse.getPosition()
                self.mouseHover = self.Contains(sx, sy)
            end

            ----------
            -- Load --
            ----------
            function Class:Load()
                self:Set_Panel(path)
            end
                 
            ---------------
            -- Set_Panel --
            ---------------
            function Class:Set_Panel(_pPath)
                self.panel = {
                    sprite = love.graphics.newImage(_pPath),
                    width  = self.panel.sprite:getWidth(),
                    height = self.panel.sprite:getHeight()
                }
            end
            
            ------------
            -- Update --
            ------------
            function Class:Update(dt)
                if(self.active) then
                    self:Input()
                    self:Alpha_To(1, self.lSpeedIN)
                else
                    self:Update_Inactive()
                end
            end
            
            ----------------
            -- Draw_Panel --
            ----------------
            function Class:Draw_Panel()
                love.graphics.setColor(0, 0, 0, 0.2 * self.alpha)
                    love.graphics.draw(
                        self.panel.sprite, 
                        self.position.x + self.shadow.x, 
                        self.position.y + self.shadow.y, 
                        self.rotation, 
                        self.scale.x, 
                        self.scale.y, 
                        self.panel.width*0.5, 
                        self.panel.height*0.5,
                        0,
                        0
                    )
                                
                love.graphics.setColor(1, 1, 1, self.alpha)
                    love.graphics.draw(
                        self.panel.sprite, 
                        self.position.x, 
                        self.position.y, 
                        self.rotation, 
                        self.scale.x, 
                        self.scale.y,
                        self.panel.width*0.5, 
                        self.panel.height*0.5,
                        0,
                        0
                    )
            end

            ----------
            -- Draw --
            ----------
            function Class:Draw()
                Class:Draw_Panel()
                Class:Draw_Label()
            end

        return Class
    end
}