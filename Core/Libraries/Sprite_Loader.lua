return {
    new = function()
        local Class = {
            lstSprites = {}
        }

        ----------------
        -- Add_Sprite --
        ----------------
        function Class:Add_Sprite(_pName, _pPath)
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

            self.lstSprites[_pName] = sprite
            if(isDebug) then print("Sprite_Loader, Added: ".._pName..".png") end
        end
        
        ----------------
        -- Get_Sprite --
        ----------------
        function Class:Get_Sprite(_pName)
            return self.lstSprites[_pName]
        end

        return Class
    end
}