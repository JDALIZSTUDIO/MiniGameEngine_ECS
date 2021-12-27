local label = require('Core/Libraries/GUI/Elements/GUI_Label')

return {
    new = function(_pX, _pY, _pString, _pFont, _pScale)
        local Class = label.new(_pX, _pY, _pString)
              Class.font     = _pFont
              Class.charW    = _pFont:getWidth(" ")
              Class.charH    = _pFont:getHeight(" ")
              Class.scale    = _pScale
              Class.strTable = {}
              Class.labelW   = 0
              Class.labelH   = 0
              Class.totalW   = 0
              Class.TotalH   = 0              
              Class.surface  = nil
              Class.padding  = { x = Class.shadow.x * 2, y = Class.shadow.y * 2 }

        local maybeScale = _pScale
        if(maybeScale) then Class.scale = { x = maybeScale.x, y = maybeScale.y } end
        
        local insert = table.insert
        local rad = math.rad
          
        ----------
        -- Load --
        ----------
        function Class:Load()
            self:Set_Label(self.label)
            self:Set_Canvas()
        end

        ----------------
        -- Set_Canvas --
        ----------------
        function Class:Set_Canvas(_pString)
            self.surface = love.graphics.newCanvas(self.totalW, self.totalH)
            self.surface:setFilter("nearest", "nearest", 16)            
            love.graphics.setCanvas(self.surface)
                love.graphics.setColor(0,0,0,1)
                love.graphics.rectangle("fill",0,0,self.totalW,self.totalH)
            love.graphics.setCanvas()
        end
        
        ---------------
        -- Set_Label --
        ---------------
        function Class:Set_Label(_PString)
            self.strTable = {}
            local l = string.len(_PString)
            for i=1, l do    
                insert(self.strTable, _PString:sub(i, i))
            end             
            self.labelW = #self.strTable * self.charW
            self.labelH = #self.strTable * self.charH            
            self.totalW = self.font:getWidth(self.label)  + self.padding.x
            self.totalH = self.font:getHeight(self.label) + self.padding.y 
        end

        
        --------------
        -- Set_Font --
        --------------
        function Class:Set_Font(_pFont)
            self.font  = _pFont
            self.charW = _pFont:getWidth(" ")
            self.charH = _pFont:getHeight(" ")
        end
        
        ----------------
        -- Draw_Label --
        ----------------
        function Class:Draw_Label()
            love.graphics.setFont(self.font)
            love.graphics.setCanvas(self.surface)
                love.graphics.clear()  

                local x, y
                for i=1, #self.strTable do
                    x = ((i-1)*self.charW) + (self.padding.x * 0.5)
                    y = 0 + (self.padding.y * 0.5)
                    
                    love.graphics.setColor(0, 0, 0, 0.2)
                        love.graphics.print(
                            self.strTable[i], 
                            x+self.shadow.x, 
                            y+self.shadow.y
                        )
                    
                    love.graphics.setColor(1, 1, 1, 1)
                        love.graphics.print(
                            self.strTable[i], 
                            x, 
                            y
                        )
                end

            love.graphics.setCanvas()
            
                love.graphics.setColor(1, 1, 1, self.alpha)
                    love.graphics.draw(
                        self.surface, 
                        self.position.x,
                        self.position.y,
                        rad(self.rotation),
                        self.scale.x,
                        self.scale.y,
                        self.totalW * 0.5,
                        self.totalH * 0.5
                    )

        end

        return Class
    end
}