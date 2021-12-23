return {
    new = function(_pName)
        local Scene = require('Libraries/Scenes/Scene_Parent').new(_pName)
        
        local ECS
        local Lighting
        local Logo
        local BG
        local LogoSX, LogoSY, BGSX, BGSY

        local lightposition

        ----------
        -- Load --
        ----------
        function Scene:Load()
            BG       = love.graphics.newImage("Images/Logo/BG.png")
            Logo     = love.graphics.newImage("Images/Logo/Logo.png")
            ECS      = require('Libraries/ECS/ECS_Manager').new()
            Lighting = require('Libraries/Lighting/Simple_Lighting').new()
            
            LogoSX = love.graphics:getWidth()  / Logo:getWidth()  / Aspect.scale
            LogoSY = love.graphics:getHeight() / Logo:getHeight() / Aspect.scale
            BGSX   = love.graphics:getWidth()  / BG:getWidth()  / Aspect.scale
            BGSY   = love.graphics:getHeight() / BG:getHeight() / Aspect.scale

            Lighting:Load(Aspect.screen.width, Aspect.screen.height)

            local light = ECS:Create()
            light:Add_Component(require('Libraries/ECS/Components/Lighting/c_Light_Source').new())
            light:Add_Component(require('Libraries/ECS/Components/Movement/c_Transform').new(Aspect.screen.width*0.5,
                                                                                            Aspect.screen.height*0.5))

            Lighting:Add(light)

            local t = light:Get_Component("transform")
            lightposition = t.position
        end

        ------------
        -- Update --
        ------------
        function Scene:Update(dt)
            if(love.mouse.isDown(1)) then
                local x, y = Camera:Screen_To_World(love.mouse.getPosition())
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
                love.graphics.draw(BG, 0, 0, 0, BGSX, BGSY)
                love.graphics.draw(Logo, 0, 0, 0, LogoSX, LogoSY)
                ECS:Draw()
            Lighting:UnSet()

        end

        return Scene
    end
}