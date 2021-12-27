local panel = require('Core/Libraries/GUI/Elements/GUI_Panel')

return {
    new = function(_pX, _pY, _pString, _pImagePath, _pFrameW, _pFrameH, _pFunction)
        local Class         = panel.new(_pX, _pY, _pString, _pImagePath)
              Class.clicked = false
              Class.func    = _pFunction
              Class.index   = 1
            
        local floor   = math.floor
        local newQuad = love.graphics.newQuad
        local insert  = table.insert
        local rad     = math.rad
        local path    = _pImagePath
        local frameW  = _pFrameW
        local frameH  = _pFrameH
        
        --------------
        -- Activate --
        --------------
        function Class:Activate(pFunc)
            pFunc()
        end            

        ---------------
        -- Get_Quads --
        ---------------
        function Class:Get_Quads(_pAtlas, _pFrameW, _pFrameH)
            local data  = {}
            local nbCol = floor(self.panel.width  / self.panel.frameWidth )
            local nbLig = floor(self.panel.height / self.panel.frameHeight)                
            local quad
            for y = 1, nbLig, 1 do
                for x = 1, nbCol, 1 do
                    quad = newQuad( (x-1)  * self.panel.frameWidth,
                                    (y-1) * self.panel.frameHeight,
                                    self.panel.frameWidth,
                                    self.panel.frameHeight,
                                    self.panel.atlas:getDimensions());
                                                
                    insert(data, quad)
                end
            end
            return data
        end

        --------------
        -- Interact --
        --------------
        function Class:Interact()
            if(self.active) then
                self:Activate(self.func)
            end
        end
            
        -----------
        -- Input --
        -----------
        function Class:Input()                
            local mx, my = love.mouse.getPosition()
            self.mouseHover = self:Contains(mx, my)
        end

        ----------
        -- Load --
        ----------
        function Class:Load()
            self:Set_Panel(path, frameW, frameH)
            self.panel.quadData = self:Get_Quads(self.panel.atlas, frameW, frameH)
        end

        ---------------
        -- Set_Panel --
        ---------------
        function Class:Set_Panel(_pPath, _pFrameW, _pFrameH)
            local atlas  = love.graphics.newImage(_pPath)
            local width  = atlas:getWidth()
            local height = atlas:getHeight()
            self.panel = {
                atlas       = atlas,
                width       = width,
                height      = height,
                quadData    = {},
                frameWidth  = _pFrameW,
                frameHeight = _pFrameH
            }
        end
        
        ------------
        -- Update --
        ------------
        function Class:Update(dt)
            if(Class.active) then
                Class:Input()
                Class:Update_MouseHover()
            else
                self:Update_Inactive()
            end
        end

        -----------------------
        -- Update_MouseHover --
        -----------------------
        function Class:Update_MouseHover()
            if(self.mouseHover) then
                self.index = 2
                self:Scale_To(self.targetScale, self.lSpeedIN)                  
                if(self.clicked == false) then
                if(love.mouse.isDown(1)) then
                    self.index   = 3
                    self.clicked = true
                    self:Interact()
                end
                end                  
            else
                self.index = 1
                self:Scale_To(1, self.lSpeedOUT)
            end      
            
            if(love.mouse.isDown(1) == false) then
                self.clicked = false
            end
            self:Alpha_To(1, self.lSpeedIN)
        end
        
        ----------------
        -- Draw_Panel --
        ----------------
        function Class:Draw_Panel()
            love.graphics.setColor(0, 0, 0, 0.2 * self.alpha)
                love.graphics.draw(
                    self.panel.atlas,
                    self.panel.quadData[self.index], 
                    self.position.x + self.shadow.x, 
                    self.position.y + self.shadow.y,
                    rad(self.rotation), 
                    self.scale.x, 
                    self.scale.y, 
                    self.panel.frameWidth*0.5, 
                    self.panel.frameHeight*0.5,
                    0,
                    0
                )
                            
            love.graphics.setColor(1, 1, 1, self.alpha)
                love.graphics.draw(
                    self.panel.atlas,
                    self.panel.quadData[self.index], 
                    self.position.x, 
                    self.position.y, 
                    rad(self.rotation), 
                    self.scale.x, 
                    self.scale.y, 
                    self.panel.frameWidth*0.5, 
                    self.panel.frameHeight*0.5,
                    0,
                    0
                )
            
        end
        
        return Class
    end
}