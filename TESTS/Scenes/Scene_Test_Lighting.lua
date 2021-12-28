return {
    new = function(_pName)
        local Scene = require('Core/Libraries/Scenes/Scene_Parent').new(_pName)
        
        local aspect
        local camera
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
            aspect   = Locator:Get_Service("aspect")
            camera   = Locator:Get_Service("camera")
            BG       = love.graphics.newImage("Game/Images/Logo/BG.png")
            Logo     = love.graphics.newImage("Game/Images/Logo/Logo.png")
            ECS      = require('Core/Libraries/ECS/ECS_Manager').new()
            Lighting = require('Core/Libraries/Lighting/Simple_Lighting').new()
            
            LogoSX = love.graphics:getWidth()  / Logo:getWidth()  / aspect.scale
            LogoSY = love.graphics:getHeight() / Logo:getHeight() / aspect.scale
            BGSX   = love.graphics:getWidth()  / BG:getWidth()    / aspect.scale
            BGSY   = love.graphics:getHeight() / BG:getHeight()   / aspect.scale

            Lighting:Load(aspect.screen.width, aspect.screen.height)

            local light = ECS:Create()
            light:Add_Component(require('Core/Libraries/ECS/Components/Lighting/c_Light_Source').new())
            light:Add_Component(require('Core/Libraries/ECS/Components/Movement/c_Transform').new(aspect.screen.width*0.5,
                                                                                                  aspect.screen.height*0.5))

            Lighting:Add(light)

            local t = light:Get_Component("transform")
            lightposition = t.position
        end

        ------------
        -- Update --
        ------------
        function Scene:Update(dt)
            if(love.mouse.isDown(1)) then
                local x, y = camera:Screen_To_World(love.mouse.getPosition())
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