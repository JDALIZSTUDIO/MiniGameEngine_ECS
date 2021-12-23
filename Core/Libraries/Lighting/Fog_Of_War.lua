return {
    new = function(_pColor)
        local FOW            = {}
              FOW.color      = nil
              FOW.components = nil
              FOW.hole       = nil
              FOW.halfW      = 0
              FOW.halfH      = 0
              FOW.removers   = nil
              FOW.surface    = nil
        
        ------------
        -- Update --
        ------------
        function FOW:Add(_pEntity)
            local fogRemover  = _pEntity:Get_Component("fogRemover")
            local transform   = _pEntity:Get_Component("transform")
            if(fogRemover ~= nil and transform ~= nil) then
                local remover = {
                    component = fogRemover,
                    position  = transform.position
                }
                table.insert(self.components, remover)
            end
        end

        ----------
        -- Load --
        ----------
        function FOW:Load(_pMapW, _pMapH, _pColor)
            local img = love.graphics.newImage("Core/Images/Fog_Of_War/Hole.png")
            
            self.components  = {}
            self.color       = _pColor or {0, 0, 0, 1}
            self.hole        = img
            self.halfW       = img:getWidth()  * 0.5
            self.halfH       = img:getHeight() * 0.5
            self.lights      = {}
            self.screen      = { _pMapW, _pMapH }
            self.surface     = love.graphics.newCanvas(_pMapW, _pMapH)
            
            self.surface:setFilter("nearest", "nearest", 16)

            love.graphics.setCanvas(self.surface)
            love.graphics.clear(self.color)
            love.graphics.setBlendMode("alpha", "premultiplied")
            love.graphics.setCanvas()
            
            love.graphics.setColor(1, 1, 1, 1)
        end

        ------------
        -- Update --
        ------------
        function FOW:Update(dt)
            self.removers = {}
            local remover, path, string, struct
            for i = #self.components, 1, -1 do
                remover = self.components[i]
                if(remover.component == nil or remover.position == nil) then                    
                    print("Fog_Of_War, Removing: 1 fog_remover")
                    table.remove(self.components, i)
                elseif(remover.component.active) then
                    struct        = {
                        position  = {remover.position.x, remover.position.y},
                        power     = remover.component.power,
                    }                    
                    table.insert(self.removers, struct)
                end
            end
        end

        ---------
        -- Set --
        ---------
        function FOW:Set()
            love.graphics.setCanvas(self.surface)            
            love.graphics.setBlendMode("multiply", "premultiplied")            
            love.graphics.setColor(1, 1, 1, 1)

            local l, scale
            for i = 1, #self.removers do
                l     = self.removers[i]
                scale = l.power / 50
                love.graphics.draw(self.hole, l.position[1], l.position[2], 0, scale, scale, self.halfW, self.halfH )
            end
            
            love.graphics.setCanvas()
            love.graphics.setBlendMode("alpha")
        end
        
        ----------
        -- Draw --
        ----------
        function FOW:Draw()
            love.graphics.setColor(1, 1, 1, 1)
            love.graphics.setBlendMode("alpha")
            love.graphics.draw(self.surface)
        end

        return FOW
    end
}