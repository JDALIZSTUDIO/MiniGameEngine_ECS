return {
    new = function()
        local Class = {
            lstAnimations = {}
        }

        -------------------
        -- Add_Animation --
        -------------------
        function Class:Add_Animation(pName, _pPath)
            local image = love.graphics.newImage(_pPath)
            local sprW  = image:getWidth()
            local sprH  = image:getHeight()

            local sprite = {
                image  = image,
                width  = sprW,
                height = sprH,
                halfW  = sprW * 0.5,
                halfH  = sprH * 0.5 
            }

            self.lstAnimations[_pName] = sprite
        end
        
        ---------------
        -- Add_Frame --
        ---------------
        function Class:Add_Frame(_pName)
            local anim = self.lstAnimations[_pName]
            if(anim == nil) then return end
        end
        
        -------------------
        -- Get_Animation --
        -------------------
        function Class:Get_Animation(_pName)
            return self.lstAnimations[_pName]
        end

        return Class
    end
}