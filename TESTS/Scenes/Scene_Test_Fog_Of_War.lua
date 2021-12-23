return {
    new = function(_pName)
        local Scene = require('Core/Libraries/Scenes/Scene_Parent').new(_pName)
        
        local ECS
        local FOW
        local Logo
        local BG
        local LogoSX, LogoSY, BGSX, BGSY

        local lightposition

        ----------
        -- Load --
        ----------
        function Scene:Load()
            BG   = love.graphics.newImage("Game/Images/Logo/BG.png")
            Logo = love.graphics.newImage("Game/Images/Logo/Logo.png")
            ECS  = require('Core/Libraries/ECS/ECS_Manager').new()
            FOW  = require('Core/Libraries/Lighting/Fog_Of_War').new()
            
            LogoSX = love.graphics:getWidth()  / Logo:getWidth()  / Aspect.scale
            LogoSY = love.graphics:getHeight() / Logo:getHeight() / Aspect.scale
            BGSX   = love.graphics:getWidth()  / BG:getWidth()  / Aspect.scale
            BGSY   = love.graphics:getHeight() / BG:getHeight() / Aspect.scale

            FOW:Load(love.graphics.getWidth(), love.graphics.getHeight())

            local light = ECS:Create()
            light:Add_Component(require('Core/Libraries/ECS/Components/Lighting/c_Fog_Remover').new())
            light:Add_Component(require('Core/Libraries/ECS/Components/Movement/c_Transform').new(0, 0))

            FOW:Add(light)

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
            FOW:Update(dt)
            FOW:Set()
        end

        ----------
        -- Draw --
        ----------
        function Scene:Draw()
            love.graphics.draw(BG, 0, 0, 0, BGSX, BGSY)
            love.graphics.draw(Logo, 0, 0, 0, LogoSX, LogoSY)
            ECS:Draw()
            FOW:Draw()
        end

        return Scene
    end
}