return {
    new = function(_pName)
        local Scene = require('Core/Libraries/Scenes/Scene_Parent').new(_pName)
        
        local ECS
        local Tilemap

        ----------
        -- Load --
        ----------
        function Scene:Load()
            ECS     = require('Core/Libraries/ECS/ECS_Manager').new()
            Tilemap = require('Core/Libraries/Tilemap/Tilemap').new()

            ECS:Register(require('Core/Libraries/ECS/Systems/Rendering/s_Box_Renderer').new())
            ECS:Register(require('Core/Libraries/ECS/Systems/Collisions/s_Bounding_Box').new())
            ECS:Register(require('Core/Libraries/ECS/Systems/Rendering/s_Box_Renderer').new())

            Tilemap:Load('Core/Libraries/Tilemap/Maps/TESTMAP4')

            local player = ECS:Create()
                  player.name = "player"
                  local t =player:Add_Component(require('Core/Libraries/ECS/Components/Movement/c_Transform').new(128, 48, 0))
                  player:Add_Component(require('Core/Libraries/ECS/Components/Collisions/c_Bounding_Box').new(0, 0, 16, 16))
                  player:Add_Component(require('Core/Libraries/ECS/Components/Rendering/c_Box_Renderer').new())

            Camera:Attach(t)
        end

        ------------
        -- Update --
        ------------
        function Scene:Update(dt)
            if(love.keyboard.isDown("space")) then Camera:Shake(2, 10) end

            ECS:Update(dt)
            Tilemap:Update(dt)
        end

        ----------
        -- Draw --
        ----------
        function Scene:Draw()
            Tilemap:DrawBack()
                ECS:Draw()
            Tilemap:DrawFront()
        end

        return Scene
    end
}