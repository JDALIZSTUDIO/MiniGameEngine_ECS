return {
    new = function(_pName)
        local Scene = require('Libraries/Scenes/Scene_Parent').new(_pName)
        
        local ECS
        local Lighting
        local logo
        local bg

        ----------------------
        -- PUBLIC FUNCTIONS --
        ----------------------

        -----------
        -- Awake --
        ----------- 
        function Scene:Awake()

        end

        ------------
        -- Unload --
        ------------
        function Scene:Unload()

        end

        ---------------
        -- PreUnload --
        ---------------
        function Scene:PreUnload()

        end

        ----------
        -- Load --
        ----------
        function Scene:Load()
            ECS      = require('Libraries/ECS/ECS_Manager').new()
            Lighting = require('Libraries/Lighting/Simple_Lighting').new()
            Lighting:Load(Aspect.screen.width, Aspect.screen.height)
            bg       = love.graphics.newImage("Images/Logo/BG.png")
            logo     = love.graphics.newImage("Images/Logo/Logo.png")

            local light = ECS:Create()
            light:AddComponent(require('Libraries/ECS/Components/c_Light_Source').new())
            light:AddComponent(require('Libraries/ECS/Components/c_Transform').new(Aspect.screen.width*0.5,
                                                                                   Aspect.screen.height*0.5))

            Lighting:Add(light)
        end

        ------------
        -- Update --
        ------------
        function Scene:Update(dt)
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

        -------------
        -- Draw_GUI --
        -------------
        function Scene:Draw_GUI()
            
        end

        return Scene
    end
}