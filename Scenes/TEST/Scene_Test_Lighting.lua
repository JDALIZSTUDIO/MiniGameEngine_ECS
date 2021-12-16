return {
    new = function(_pName)
        local Scene = require('Libraries/Scenes/Scene_Parent').new(_pName)
        
        local ECS
        local Lighting
        local logo
        local bg

        local lightposition

        ----------
        -- Load --
        ----------
        function Scene:Load()
            bg       = love.graphics.newImage("Images/Logo/BG.png")
            logo     = love.graphics.newImage("Images/Logo/Logo.png")
            ECS      = require('Libraries/ECS/ECS_Manager').new()
            Lighting = require('Libraries/Lighting/Simple_Lighting').new()
            
            Lighting:Load(Aspect.screen.width, Aspect.screen.height)

            local light = ECS:Create()
            light:AddComponent(require('Libraries/ECS/Components/Lighting/c_Light_Source').new())
            light:AddComponent(require('Libraries/ECS/Components/Movement/c_Transform').new(Aspect.screen.width*0.5,
                                                                                            Aspect.screen.height*0.5))

            Lighting:Add(light)

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
            Lighting:Update(dt)
        end

        ----------
        -- Draw --
        ----------
        function Scene:Draw()
            Lighting:Set()
                love.graphics.draw(bg, 0, 0)
                love.graphics.draw(logo, 0, 0)
                ECS:Draw()
            Lighting:UnSet()

        end

        return Scene
    end
}