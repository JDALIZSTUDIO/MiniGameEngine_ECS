return {
    new = function(_pName)
        local Scene = require('Libraries/Scenes/Scene_Parent').new(_pName)
        
        local ECS
        local FOW
        local logo
        local bg

        local lightposition

        ----------
        -- Load --
        ----------
        function Scene:Load()
            bg   = love.graphics.newImage("Images/Logo/BG.png")
            logo = love.graphics.newImage("Images/Logo/Logo.png")
            ECS  = require('Libraries/ECS/ECS_Manager').new()
            FOW  = require('Libraries/Lighting/Fog_Of_War').new()
            
            FOW:Load(love.graphics.getWidth(), love.graphics.getHeight())
            --FOW:Load(Aspect.screen.width, Aspect.screen.height)

            local light = ECS:Create()
            light:AddComponent(require('Libraries/ECS/Components/Lighting/c_Fog_Remover').new())
            light:AddComponent(require('Libraries/ECS/Components/Movement/c_Transform').new(0, 0))

            FOW:Add(light)

            local t = light:GetComponent("transform")
            lightposition = t.position
        end

        ------------
        -- Update --
        ------------
        function Scene:Update(dt)
            if(love.mouse.isDown(1)) then
                local x, y = Screen_To_World(love.mouse.getPosition())
                lightposition:Set(x, y)
            end

            ECS:Update(dt)
            FOW:Update(dt)
            FOW:Set()
        end

        ----------
        -- Draw --
        ----------
        function Scene:Draw()
            love.graphics.draw(bg, 0, 0)
            love.graphics.draw(logo, 0, 0)
            ECS:Draw()
            FOW:Draw()
        end

        return Scene
    end
}